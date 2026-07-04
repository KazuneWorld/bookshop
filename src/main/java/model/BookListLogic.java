package model;
import java.util.List;

import dao.BooksDAO;

//書籍リストを取得関連のロジック
public class BookListLogic {
    
	//全書籍リストを取得（おすすめ？）
	public List<Book> execute(){
		BooksDAO dao = new BooksDAO();
		List<model.Book> bookList = dao.goodBooks();
		return bookList;
	}
	//キーワード検索実行
	public List<Book> searchExecute(String keyword, String category) {
		BooksDAO dao = new BooksDAO();
		List<model.Book> bookList = dao.findByTitle(keyword, category);
        return bookList;
    }
	//人気ランキングTOP5取得
	public List<OrderDetail> getTop5Books() {
	    dao.Order_DetailDAO orderDetailDAO = new dao.Order_DetailDAO();
	    List<OrderDetail> topBooks = orderDetailDAO.top5OrderedBooks();
	    return topBooks;
	}
    
}



