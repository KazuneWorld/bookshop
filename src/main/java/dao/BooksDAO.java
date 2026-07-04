package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Book;

public class BooksDAO {

	// データベース接続に使用する情報
private final String JDBC_URL = "jdbc:mysql://localhost/bookshop";
	private final String DB_USER = "root";
	private final String DB_PASS = "";


	// 全書籍一覧取得
	public List<Book> findAllBooks() {

		List<Book> bookList = new ArrayList<>();
		// JDBCドライバを読み込む
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCを読み込めませんでした");
		}
		// データベース接続
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {

			// SELECT文の準備
			String sql = "SELECT bookID, writer, company, title, price, stock, image, category, good_flg FROM books ORDER BY category";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SELECT文を実行
			ResultSet rs = pStmt.executeQuery();

			// SELECT文の結果をArrayListに格納
			while (rs.next()) {
				int bookId = rs.getInt("bookID");
				String title = rs.getString("title");
				String writer = rs.getString("writer");
				String company = rs.getString("company");
				int price = rs.getInt("price");
				int stock = rs.getInt("stock");
				String image = rs.getString("image");
				int category = rs.getInt("category");
				int good_flg = rs.getInt("good_flg");
				Book book = new Book(bookId, title, writer, company, price, stock, image, category, good_flg);
				bookList.add(book);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return bookList;
	}

	// おすすめ書籍一覧取得？？？
	public List<Book> goodBooks() {

		List<Book> bookList = new ArrayList<>();

		// JDBCドライバを読み込む
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}
		
		// データベース接続
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {

			// SELECT文の準備
			String sql = "SELECT bookID, writer, company, title, price, stock, image, category, good_flg FROM books WHERE good_flg = 1";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SELECT文を実行
			ResultSet rs = pStmt.executeQuery();

			// SELECT文の結果をArrayListに格納
			while (rs.next()) {
				int bookId = rs.getInt("bookID");
				String title = rs.getString("title");
				String writer = rs.getString("writer");
				String company = rs.getString("company");
				int price = rs.getInt("price");
				int stock = rs.getInt("stock");
				String image = rs.getString("image");
				int category = rs.getInt("category");
				int good_flg = rs.getInt("good_flg");
				Book book = new Book(bookId, title, writer, company, price, stock, image, category, good_flg);
				bookList.add(book);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return bookList;
	}

	// キーワードで検索
	public List<Book> findByTitle(String keyword, String category) {

		List<Book> bookList = new ArrayList<>();
		
		// カテゴリ指定がある場合はSQL文を変更
		String sql;
		if (category != null && !category.isEmpty()) {
			sql = "SELECT bookID,writer,company,title,price,stock,image, category, good_flg FROM books WHERE (title LIKE ? OR company LIKE ?) AND category = ?";
		} else {
			sql = "SELECT bookID,writer,company,title,price,stock,image, category, good_flg FROM books WHERE title LIKE ? OR company LIKE ?";
		}
		
		// データベース接続
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {

			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, "%" + keyword + "%");
			pStmt.setString(2, "%" + keyword + "%");
			
			// カテゴリ指定がある場合はパラメータを追加
			if (category != null && !category.isEmpty()) {
				pStmt.setInt(3, Integer.parseInt(category));
			}

			// SELECT文を実行
			ResultSet rs = pStmt.executeQuery();

			// SELECT文の結果をArrayListに格納
			while (rs.next()) {
				int bookId = rs.getInt("bookID");
				String title = rs.getString("title");
				String writer = rs.getString("writer");
				String company = rs.getString("company");
				int price = rs.getInt("price");
				int stock = rs.getInt("stock");
				String image = rs.getString("image");
				int categoryValue = rs.getInt("category");
				int good_flg = rs.getInt("good_flg");
				Book book = new Book(bookId, title, writer, company, price, stock, image, categoryValue, good_flg );
				bookList.add(book);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return bookList;
	}


	// 書籍IDから1冊の本を取得
	public Book findById(int bookId) {

		Book book = null;

		/*try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCを読み込めませんでした");
		}*/

		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {

			    String sql = "SELECT bookID, writer, company, title, price, stock, good_flg, image, category, good_flg "
				    + "FROM books WHERE bookID = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, bookId);

			ResultSet rs = pStmt.executeQuery();

			if (rs.next()) {
				book = new Book(
						rs.getInt("bookID"),
						rs.getString("title"),
						rs.getString("writer"),
						rs.getString("company"),
						rs.getInt("price"),
						rs.getInt("stock"),
						rs.getString("image"),
						rs.getInt("category"),
				        rs.getInt("good_flg"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return book;
	}

	
	//書籍の削除
	public boolean deleteBook(int bookId) {

		boolean isDeleted = false;

		/*try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCを読み込めませんでした");
		}*/

		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {

			String sql = "DELETE FROM books WHERE bookID = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, bookId);

			int result = pStmt.executeUpdate();

			if (result > 0) {
				isDeleted = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return isDeleted;
	}

	
	//書籍情報編集
	public Book updateBook(Book book, int bookId) {

		Book isUpdated = null;

		/*try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCを読み込めませんでした");
		}*/

		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {


			String sql = "UPDATE books SET  title = ?, writer = ?, company = ?,  price = ?, stock = ?, category = ?, image = ?, good_flg = ? WHERE bookID = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			// 更新する値
			pStmt.setString(1, book.getTitle());
			pStmt.setString(2, book.getWriter());
			pStmt.setString(3, book.getCompany());
			pStmt.setInt(4, book.getPrice());
			pStmt.setInt(5, book.getStock());
			pStmt.setInt(6, book.getCategory());
			pStmt.setString(7, book.getImage());
			pStmt.setInt(8, book.getGood_flg());
			// WHERE句の条件(ID)
			pStmt.setInt(9, bookId);
			int result = pStmt.executeUpdate();
			if (result > 0) {
				isUpdated = book;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return isUpdated;
	}
	
	//新商品追加
	public boolean insertBook(Book book) {
		/*try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCを読み込めませんでした");
		}*/
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {

			String sql = "INSERT INTO books (title, writer, company, price, stock, category, image, good_flg) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, book.getTitle());
			pStmt.setString(2, book.getWriter());
			pStmt.setString(3, book.getCompany());
			pStmt.setInt(4, book.getPrice());
			pStmt.setInt(5, book.getStock());
			pStmt.setInt(6, book.getCategory());
			pStmt.setString(7, book.getImage());
			pStmt.setInt(8, book.getGood_flg());
			//sql実行
			pStmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}

	// 在庫減少（トランザクション用）
	public boolean decreaseStock(Connection conn, int bookId, int quantity) throws SQLException {
		// 1. 念には念を入れて現在の在庫を最終確認
		String checkSql = "SELECT stock FROM books WHERE bookID = ?";
		try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
			checkStmt.setInt(1, bookId);
			ResultSet rs = checkStmt.executeQuery();
			if (rs.next()) {
				int currentStock = rs.getInt("stock");
				if (currentStock < quantity) {
					return false; // 在庫不足
				}
			} else {
				return false; // 書籍が存在しない
			}
		}
		// 2. 在庫を減少
		String sql = "UPDATE books SET stock = stock - ? WHERE bookID = ?";
		try (PreparedStatement pStmt = conn.prepareStatement(sql)) {
			pStmt.setInt(1, quantity);
			pStmt.setInt(2, bookId);
			pStmt.executeUpdate();
			return true;
		}
	}

	// 在庫増加（トランザクション用）
	public boolean increaseStock(Connection conn, int bookId, int quantity) throws SQLException {
		String sql = "UPDATE books SET stock = stock + ? WHERE bookID = ?";
		try (PreparedStatement pStmt = conn.prepareStatement(sql)) {
			pStmt.setInt(1, quantity);
			pStmt.setInt(2, bookId);
			int result = pStmt.executeUpdate();
			return result == 1;
		}
	}

	// ------------------------------------------------------------
	// 以下はDB未接続時の動作確認用（必要なときだけコメントアウトを外して使用）
	/*
	public List<Book> goodBooks() {
		List<Book> bookList = new ArrayList<>();
		bookList.add(new Book(1, "Sample Title 1", "Author A", "Publisher X", 1200, 5,"sample1.jpg"));
		bookList.add(new Book(2, "Sample Title 2", "Author B", "Publisher Y", 1800, 2,null));
		bookList.add(new Book(3, "Sample Title 3", "Author C", "Publisher Z", 2200, 0,"sample3.jpg"));
		return bookList;
	}
	public List<Book> search(String keyword) {
		return goodBooks(); // 簡易: 全件返すだけ
	}
	public Book findById(int bookId) {
		return goodBooks().stream()
			.filter(b -> b.getBookId() == bookId)
			.findFirst()
			.orElse(null);
	}
	public List<Book> findByTitle(String keyword) {
		return goodBooks(); // 簡易: 全件返すだけ
	}
	public Book updateBook(Book book, int bookId) {
		return book; // 簡易: 渡されたオブジェクトをそのまま返すだけ
	}
	*/
	// ------------------------------------------------------------

}
