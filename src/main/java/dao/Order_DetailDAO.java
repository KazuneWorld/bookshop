package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Order;
import model.OrderDetail;
import model.User;

public class Order_DetailDAO {

private final String JDBC_URL = "jdbc:mysql://localhost/bookshop";
	private final String DB_USER = "root";
	private final String DB_PASS = "";



    // ---------------------------
    // ユーザーの注文一覧を取得（OrderDetail もセット）
    // ---------------------------
    public List<Order> getMyOrders(User user) {
        List<Order> orderList = new ArrayList<>();

        String sql = """
            SELECT orderID, userID, order_date, deliveryDate, deliveryFlg
            FROM orders
            WHERE userID = ?
            ORDER BY order_date DESC
            """;

        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getUserid());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int orderId = rs.getInt("orderID");
                int userId = rs.getInt("userID");
                String orderDate = rs.getString("order_date");

                Order order = new Order(orderId, userId, orderDate);

                // ★ 配送情報をセット (someoka版から)
                order.setDeliveryDate(rs.getDate("deliveryDate"));
                order.setDeliveryFlg(rs.getBoolean("deliveryFlg"));

                // 注文詳細を取得してセット
                List<OrderDetail> details = getOrderDetailsByOrderId(orderId);
                order.setOrderDetails(details);

                orderList.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderList;
    }


    // ---------------------------
    // 注文IDに紐づく注文詳細を取得（books情報をJOIN）
    // ---------------------------
    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT b.title, b.price, od.quantity, b.image " +
                     "FROM order_detail od " +
                     "JOIN books b ON od.bookID = b.bookID " +
                     "WHERE od.orderID = ?";

        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String title = rs.getString("title");
                double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                String image = rs.getString("image");  // nomoto版から追加

                orderDetails.add(new OrderDetail(title, price, quantity, image));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderDetails;
    }


    // ---------------------------
    // 注文IDで単一注文＋詳細を取得
    // ---------------------------
    public Order getOrderById(int orderId) {
        Order order = null;
        String sql = "SELECT orderID, userID, order_date FROM orders WHERE orderID=?";

        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("userID");
                String orderDate = rs.getString("order_date");

                order = new Order(orderId, userId, orderDate);
                order.setOrderDetails(getOrderDetailsByOrderId(orderId));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return order;
    }
    
    // ---------------------------
    // Admin専用全取得
    // ---------------------------
    public List<Order> getAllOrder() {
        List<Order> orderList = new ArrayList<>();
        String sql = "SELECT * FROM orders";

        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int orderId = rs.getInt("orderID");
                int userId = rs.getInt("userID");
                String orderDate = rs.getString("order_date");

                Order order = new Order(orderId, userId, orderDate);

                // 注文詳細を取得してセット
                List<OrderDetail> details = getOrderDetailsByOrderId(orderId);
                order.setOrderDetails(details);

                orderList.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderList;
    }

    // ---------------------------
    // 人気ランキング用 注文明細から注文冊数の多い本TOP5を取得（idとtitleとimage）
    // ---------------------------
    public List<OrderDetail> top5OrderedBooks() {
        List<OrderDetail> topBooks = new ArrayList<>();
        String sql = "SELECT b.bookID, b.title, b.image, SUM(od.quantity) AS total_quantity " +
                     "FROM order_detail od " +
                     "JOIN books b ON od.bookID = b.bookID " +
                     "GROUP BY od.bookID " +
                     "ORDER BY total_quantity DESC " +
                     "LIMIT 5";

        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int bookId = rs.getInt("bookID");
                String title = rs.getString("title");
                String image = rs.getString("image");

                OrderDetail detail = new OrderDetail(bookId, title, image);
                topBooks.add(detail);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return topBooks;
    }

}