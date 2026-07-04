package servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Book;
import model.BookListLogic;
import model.UserPageSelector;

/**
 * Servlet implementation class Main_Servlet
 */
@WebServlet("/Main")
public class Main_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 表示データを準備
		UserPageSelector userPageSelector = new UserPageSelector();
		userPageSelector.prepareMainPageData(request);
		
		// 書籍リストを取得
		BookListLogic bookListLogic =new BookListLogic();
		//bookリストを取得して、リクエストスコープに保存
		List<Book> bookList = bookListLogic.execute();
		request.setAttribute("bookList", bookList);	
		// 人気ランキングTOP5を取得してリクエストスコープに保存
		List<model.OrderDetail> topBooks = bookListLogic.getTop5Books();
		request.setAttribute("topBooks", topBooks);


		//フォワード
		String jspPath = (String) request.getAttribute("jspPath");
		RequestDispatcher dispatcher = request.getRequestDispatcher(jspPath);
		dispatcher.forward(request, response);
	}


}
