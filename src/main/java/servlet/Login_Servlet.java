package servlet;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.LoginLogic;
import model.User;

/**
 * Servlet implementation class Login_Servlet
 */
@WebServlet("/Login")
public class Login_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// jspから送られるリクエストパラメータの取得
		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("name");
		String pass = request.getParameter("pass");

		// Userインスタンス（ユーザー情報）の生成
		User inputUser = new User(name, pass);

		// ログイン処理の呼び出し
		LoginLogic loginLogic = new LoginLogic();
		User loginUser = loginLogic.execute(inputUser);

		// ログイン成功時の処理
		if (loginUser != null) {
			// ユーザー情報をセッションスコープに保存
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", loginUser);
		} else {
			// ログイン失敗時の処理
			// エラーメッセージをリクエストスコープに保存
			request.setAttribute("errorMsg", "ユーザー名またはメールアドレス・パスワードが間違っています");
			// 入力された名前を入力欄に保持用
			request.setAttribute("inputName", name);
		}

		// ログイン結果に応じて遷移
		if (loginUser != null) {
			// ログイン成功時はMainページにリダイレクト
			response.sendRedirect("Main");
		} else {
			// ログイン失敗時はlogin.jspにフォワード
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);
		}
	}

}
