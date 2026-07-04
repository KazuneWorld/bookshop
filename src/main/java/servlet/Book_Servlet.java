//検索結果,商品ページ,本詳細表示
package servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.BooksDAO;
import model.Book;
import model.BookListLogic;
import model.User;

@WebServlet("/Book")
public class Book_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//ログインしているか確認するため
		//セッションスコープからユーザー情報を取得
		HttpSession session = request.getSession();
		User loginUser = (User)session.getAttribute("loginUser");
		
		String forwardPath = null;
		String bookId = request.getParameter("bookId");
		String keyword = request.getParameter("keyword");
		String category = request.getParameter("category");
		
		// bookIdパラメータがある場合 → 本詳細表示
		if (bookId != null && !bookId.isEmpty()) {
				int bookIdInt = Integer.parseInt(bookId);
				
				// DAOから本の情報を取得
				BooksDAO dao = new BooksDAO();
				Book book = dao.findById(bookIdInt);
				
				// 本情報をリクエストスコープにセット
				request.setAttribute("book", book);
				
				// ユーザーに応じて詳細ページを切り替え
				if(loginUser == null) {
					forwardPath = "/WEB-INF/jsp/guest/guest_Book.jsp";
				} else {
					forwardPath = "/WEB-INF/jsp/user/user_Book.jsp";
				}
		} 
		// keywordパラメータがある場合 → 検索結果表示
		else {
			BookListLogic bookListLogic = new BookListLogic();
			
			//検索書籍リストを取得して、リクエストスコープに保存
			List<Book> bookList = bookListLogic.searchExecute(keyword, category);
			request.setAttribute("bookList", bookList); // 検索
			request.setAttribute("keyword", keyword); // 検索ワード保持用
			request.setAttribute("category", category); // カテゴリ保持用
			
			if(loginUser == null) {
			   forwardPath = "WEB-INF/jsp/guest/guest_Search.jsp";
			}else if(loginUser.isUser()){
			   forwardPath = "WEB-INF/jsp/user/user_Search.jsp";
			}else if(loginUser.isAdmin()){
				forwardPath = "WEB-INF/jsp/admin/admin_Search.jsp";
			}
		}
				
		//フォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher(forwardPath);
		dispatcher.forward(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
