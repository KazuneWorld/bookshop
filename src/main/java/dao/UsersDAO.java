package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import model.User;

public class UsersDAO {

	// データベース接続に使用する情報
private final String JDBC_URL = "jdbc:mysql://localhost/bookshop";
	private final String DB_USER = "root";
	private final String DB_PASS = "";



	// ログイン認証を行うメソッド
	public User certification(User inputUser) {

		// 戻り値の宣言 初期化
		User returnUser = null;

		// JDBCドライバを読み込む
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}
		
		// データベース接続
		String sql = "SELECT userID, name, pass, address, admin_flg FROM users "
					+"WHERE ( name = ? OR address = ? ) AND pass=? AND admin_flg IS NOT NULL";

		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
				PreparedStatement stmt = conn.prepareStatement(sql)) {

			stmt.setString(1, inputUser.getName());
			stmt.setString(2, inputUser.getName());
			stmt.setString(3, inputUser.getPass());

			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				int id = rs.getInt("userID");
				String name = rs.getString("name");
				String pass = rs.getString("pass");
				String address = rs.getString("address");
				int adminFlg = rs.getInt("admin_flg");
				
				returnUser = new User(id, name, pass, address, adminFlg);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}

		return returnUser;
	}


	// 会員登録を行うメソッド
	public boolean insert(User user) {

		// JDBCドライバを読み込む
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}
	
		String sql = "INSERT INTO users(name, pass, address) VALUES(?, ?, ?)";

		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getPass());
			pstmt.setString(3, user.getAddress());

			pstmt.executeUpdate();
			return true;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}


	// 本人確認用（名前＋パスワード）
	public User findByNameAndPass(String name, String pass) {

		User user = null;

		String sql = "SELECT name, pass, address FROM users WHERE name=? AND pass=?";

		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, name);
			pstmt.setString(2, pass);

			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				user = new User(
					rs.getString("name"),
					rs.getString("pass"),
					rs.getString("address")
				);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return user; // ← 見つからなければ null
	}


	// メールアドレス変更
	public boolean updateMail(String name, String address) {
		String sql = "UPDATE users SET address=? WHERE name=?";

		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
				PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, address);
			ps.setString(2, name);
			ps.executeUpdate();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}


	// パスワード変更
	public boolean updatePass(String name, String pass) {
		String sql = "UPDATE users SET pass=? WHERE name=?";

		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
				PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, pass);
			ps.setString(2, name);
			ps.executeUpdate();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}




	// ユーザー一覧を出すメソッド
	public List<User> findAllUsers() {

		List<User> users = new ArrayList<>();

		/*try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした", e);
		}*/
		// ユーザーを取得するSQL
		// admin_flgが1のユーザーが上,admin_flgが0のユーザーは下
		String sql = "SELECT userID, name, address, pass, admin_flg FROM users ORDER BY admin_flg DESC";

		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
				PreparedStatement pStmt = conn.prepareStatement(sql);
				ResultSet rs = pStmt.executeQuery()) {

			while (rs.next()) {
			    int userID = rs.getInt("userID");
			    String name = rs.getString("name");
			    String pass = rs.getString("pass");
			    String address = rs.getString("address");
			    Integer adminFlg = rs.getInt("admin_flg");
			    User user = new User(userID, name, pass, address, adminFlg);
			    users.add(user);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			return Collections.emptyList(); // ←とりまエラー時は空のリストを返すようにしてる
		}

		return users;
	}

	// ユーザー名・メールアドレス編集（管理者操作）
	public boolean updateUser(int userId, String name, String address) {
		String sql = "UPDATE users SET name=?, address=? WHERE userID=?";
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, name);
			ps.setString(2, address);
			ps.setInt(3, userId);
			int result = ps.executeUpdate();
			return result > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}


	//ユーザーの退会
	public boolean deleteUser(int userId) {

		boolean isDeleted = false;

		/*try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCを読み込めませんでした");
		}*/

		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {

			String sql = "DELETE FROM users WHERE userID = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, userId);

			int result = pStmt.executeUpdate();

			if (result > 0) {
				isDeleted = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return isDeleted;
	}
















	// ------------------------------------------------------------------------
	// 以下はDB未接続時の動作確認用（必要なときだけコメントアウトを外して使用）
	/*
	public User certification(User inputUser) {
		if ("user1".equals(inputUser.getName()) && "1234".equals(inputUser.getPass())) {
			return new User(
				1,
				inputUser.getName(),
				inputUser.getPass(),
				"user1@example.com",
				0
			);
		} else if ("admin".equals(inputUser.getName()) && "1234".equals(inputUser.getPass())) {
			return new User(
				2,
				inputUser.getName(),
				inputUser.getPass(),
				"admin@example.com",
				1
			);
		} else {
			return null;
		}
	}
	public boolean insert(User user) {
		return true;
	}
	public User findByNameAndPass(String name, String pass) {
		if ("user1".equals(name)
		&& "1234".equals(pass)) {
			return new User(
			name,
			pass
			);
		}else {
			return null;
		}
	}
	public boolean updateMail(String name, String address) {
		return true;
	}
	public boolean updatePass(String name, String pass) {
		return true;
	}
	public boolean deleteUser(int userId) {
		return true;
	}
	public List<User> findAllUsers() {
		List<User> users = new ArrayList<>();
		//管理者と一般ユーザーを表示
		users.add(new User(1, "admin", "1234", "admin@example.com", 1));
		users.add(new User(2, "user1", "1234", "user1@example.com", 0));
		return users;
	}
	*/
	// ------------------------------------------------------------

}