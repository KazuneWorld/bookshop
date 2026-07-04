package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import model.Book;
import model.Order;
import model.User;

public class OrdersDAO {

private final String JDBC_URL = "jdbc:mysql://localhost/bookshop";
	private final String DB_USER = "root";
	private final String DB_PASS = "";


	// 注文登録
	public boolean insertOrder(User loginUser, List<Book> cart) {
		if (loginUser == null || cart == null || cart.isEmpty()) {
			System.out.println("ユーザー未ログインまたはカートが空です");
			return false;
		}

		Connection conn = null;
		PreparedStatement orderStmt = null;
		PreparedStatement detailStmt = null;
		ResultSet rs = null;

		try {
			conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
			conn.setAutoCommit(false); // トランザクション開始

			// 1️⃣ orders テーブルに注文ヘッダを登録 (orderidはAUTO_INCREMENTなので書かない)
			String orderSql = "INSERT INTO orders (userID, order_date) VALUES (?, ?)";
			orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);

			LocalDateTime now = LocalDateTime.now();
			DateTimeFormatter dtformat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			String orderDate = dtformat.format(now);

			orderStmt.setInt(1, loginUser.getUserid());
			orderStmt.setString(2, orderDate);

			int affected = orderStmt.executeUpdate();
			if (affected != 1) {
				conn.rollback();
				return false;
			}

			// 生成された orderID を取得
			rs = orderStmt.getGeneratedKeys();
			if (!rs.next()) {
				conn.rollback();
				return false;
			}
			int orderId = rs.getInt(1);  // ←ここがAUTO_INCREMENTで生成されたID

			// 2️⃣ order_detail にカートの内容を登録し、在庫を減少
			String detailSql = "INSERT INTO order_detail (orderID, bookID, quantity) VALUES (?, ?, ?)";
			detailStmt = conn.prepareStatement(detailSql);

			BooksDAO booksDAO = new BooksDAO();

			for (Book b : cart) {
				// order_detail 登録
				detailStmt.setInt(1, orderId);
				detailStmt.setInt(2, b.getBookId());
				detailStmt.setInt(3, b.getQuantity());
				detailStmt.executeUpdate();

				// stock 減少
				//booksDAO.decreaseStockに依頼
				if (!booksDAO.decreaseStock(conn, b.getBookId(), b.getQuantity())) {
					conn.rollback();
					return false;
				}
			}

			conn.commit(); // コミット
			return true;

		} catch (SQLException e) {
			e.printStackTrace();
			try { if (conn != null) conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
			return false;
		} finally {
			try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
			try { if (orderStmt != null) orderStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
			try { if (detailStmt != null) detailStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
			try { if (conn != null) { conn.setAutoCommit(true); conn.close(); } } catch (SQLException e) { e.printStackTrace(); }
		}
	}

	// 注文キャンセル
	public boolean cancelOrder(int orderId) {

		Connection conn = null;
		PreparedStatement selectStmt = null;
		PreparedStatement deleteDetailStmt = null;
		PreparedStatement deleteOrderStmt = null;
		ResultSet rs = null;

		try {
			conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
			conn.setAutoCommit(false); // トランザクション開始

			// 1️⃣ order_detail から bookID, quantity を取得
			String selectSql = "SELECT bookID, quantity FROM order_detail WHERE orderID = ?";
			selectStmt = conn.prepareStatement(selectSql);
			selectStmt.setInt(1, orderId);
			rs = selectStmt.executeQuery();

			// 2️⃣ stock を元に戻す
			BooksDAO booksDAO = new BooksDAO();

			while (rs.next()) {
				int bookId = rs.getInt("bookID");
				int quantity = rs.getInt("quantity");

				// booksDAO.increaseStockに依頼
				if (!booksDAO.increaseStock(conn, bookId, quantity)) {
					conn.rollback();
					return false;
				}
			}

			// 3️⃣ order_detail 削除
			String deleteDetailSql = "DELETE FROM order_detail WHERE orderID = ?";
			deleteDetailStmt = conn.prepareStatement(deleteDetailSql);
			deleteDetailStmt.setInt(1, orderId);
			deleteDetailStmt.executeUpdate();

			// 4️⃣ orders 削除
			String deleteOrderSql = "DELETE FROM orders WHERE orderID = ?";
			deleteOrderStmt = conn.prepareStatement(deleteOrderSql);
			deleteOrderStmt.setInt(1, orderId);

			int affected = deleteOrderStmt.executeUpdate();
			if (affected != 1) {
				conn.rollback();
				return false;
			}

			conn.commit();
			return true;

		} catch (SQLException e) {
			e.printStackTrace();
			try { if (conn != null) conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
			return false;

		} finally {
			try { if (rs != null) rs.close(); } catch (SQLException e) {}
			try { if (selectStmt != null) selectStmt.close(); } catch (SQLException e) {}
			try { if (deleteDetailStmt != null) deleteDetailStmt.close(); } catch (SQLException e) {}
			try { if (deleteOrderStmt != null) deleteOrderStmt.close(); } catch (SQLException e) {}
			try { if (conn != null) { conn.setAutoCommit(true); conn.close(); } } catch (SQLException e) {}
		}
	}
	private Connection getConnection() throws SQLException {
	    return DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
	}


	// すべての注文を取得
	
	public List<Order> getAllOrder() {
	    List<Order> orderList = new ArrayList<>();
	    String sql = "SELECT * FROM orders";

	    try (Connection conn = getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql);
	         ResultSet rs = stmt.executeQuery()) {

	        while (rs.next()) {
	            int orderId = rs.getInt("orderID");
	            int userId = rs.getInt("userID");
	            String orderDate = rs.getString("order_date");

	            Date deliveryDate = rs.getDate("deliveryDate");
	            boolean deliveryFlg = rs.getBoolean("deliveryFlg");

	            Order order = new Order(orderId, userId, orderDate);
	            order.setDeliveryDate(deliveryDate);
	            order.setDeliveryFlg(deliveryFlg);

	            orderList.add(order);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return orderList;
	}
	
	// 配送日を更新するメソッド
	public boolean updateDeliveryDate(int orderId, java.sql.Date deliveryDate) {
	    String sql = "UPDATE orders SET deliveryDate = ? WHERE orderID = ?";

	    try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        ps.setDate(1, deliveryDate);
	        ps.setInt(2, orderId);

	        return ps.executeUpdate() == 1;

	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}


	// 配送完了フラグ更新（配送完了／未完了）
	public boolean updateDeliveryFlg(int orderId, boolean deliveryFlg) {

	    String sql = "UPDATE orders SET deliveryFlg = ? WHERE orderID = ?";

	    try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        ps.setBoolean(1, deliveryFlg);
	        ps.setInt(2, orderId);

	        return ps.executeUpdate() == 1;

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}


}

