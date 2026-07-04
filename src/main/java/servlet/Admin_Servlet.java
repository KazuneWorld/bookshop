package servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.BooksDAO;
import dao.OrdersDAO;
import dao.UsersDAO;
import model.AdminBookLogic;
import model.AdminUserLogic;
import model.Book;
import model.ImageUploadLogic;
import model.Order;
import model.User;

/**
 * Servlet implementation class Admin_Servlet
 */
@WebServlet("/Admin")
@jakarta.servlet.annotation.MultipartConfig
public class Admin_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Admin_Servlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String forwardPath = null;

        if (action == null)
            action = "";

        switch (action) {
            case "bookAdd": {
                // 新商品追加処理
                forwardPath = "/WEB-INF/jsp/admin/admin_NewBookRegister.jsp";
                break;
            }
            case "bookList": {
                // 管理者用書籍一覧表示（リスト形式）処理
                String keyword = request.getParameter("keyword");
                String category = request.getParameter("category");
                List<Book> bookList;
                
                boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
                boolean hasCategory = category != null && !category.trim().isEmpty();
                
                if (hasKeyword || hasCategory) {
                    // 検索処理（キーワードまたはカテゴリが指定されている場合）
                    model.BookListLogic bookListLogic = new model.BookListLogic();
                    bookList = bookListLogic.searchExecute(keyword, category);
                    request.setAttribute("keyword", keyword);
                    request.setAttribute("category", category);
                } else {
                    // 全件取得
                    BooksDAO booksDao = new BooksDAO();
                    bookList = booksDao.findAllBooks();
                }
                
                request.setAttribute("bookList", bookList);
                forwardPath = "/WEB-INF/jsp/admin/admin_BookList.jsp";
                break;
            }
            case "userList": {
                // ユーザー一覧表示
                if ("userList".equals(action)) {
                    UsersDAO usersDao = new UsersDAO();
                    List<User> userList = usersDao.findAllUsers();
                    request.setAttribute("userList", userList);
                    RequestDispatcher dispatcher = request
                            .getRequestDispatcher("/WEB-INF/jsp/admin/admin_UserList.jsp");
                    dispatcher.forward(request, response);
                    return;
                }
                break;
            }
            case "orderList": {
                // 注文一覧表示処理（OrdersDAOを使用して配送日・配送フラグを取得）
                OrdersDAO ordersDao = new OrdersDAO();
                List<Order> orderList = ordersDao.getAllOrder(); // Admin用全注文取得
                request.setAttribute("orderList", orderList);
                forwardPath = "/WEB-INF/jsp/admin/admin_OrderList.jsp";
                break;
            }

            case "bookEdit": {
                // 本編集処理
                String strBookId = request.getParameter("bookId");
                if (strBookId == null || strBookId.isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/admin_Top.jsp");
                    return;
                }
                int bookId = Integer.parseInt(strBookId);
                BooksDAO dao = new BooksDAO();
                Book book = dao.findById(bookId);
                request.setAttribute("book", book);
                forwardPath = "/WEB-INF/jsp/admin/admin_BookEdit.jsp";
                break;
            }
            default: {
                // 管理ページメニュー表示
                forwardPath = "/WEB-INF/jsp/admin/admin_Page.jsp";
                break;
            }
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher(forwardPath);
        dispatcher.forward(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        if (action == null) action = "";
        
        switch (action) {
            case "add": {
                // 新商品追加処理
                String title = request.getParameter("title");
                String writer = request.getParameter("writer");
                String company = request.getParameter("company");
                String priceStr = request.getParameter("price");
                String stockStr = request.getParameter("stock");
                String categoryStr = request.getParameter("category");
                String good = request.getParameter("good");
                
                // 画像ファイルのアップロード処理
                ImageUploadLogic imageLogic = new ImageUploadLogic();
                String imageFileName = null;
                try {
                    jakarta.servlet.http.Part filePart = request.getPart("image");
                    imageFileName = imageLogic.uploadImage(filePart, getServletContext());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                
                if (title != null && writer != null && company != null && priceStr != null && stockStr != null && categoryStr != null) {
                    AdminBookLogic bookLogic = new AdminBookLogic();
                    boolean success = bookLogic.addBook(title, writer, company, priceStr, stockStr, imageFileName, categoryStr, good);
                    if (success) {
                        request.setAttribute("message", "商品を追加しました");
                    } else {
                        request.setAttribute("message", "入力値が不正です");
                    }
                }
                response.sendRedirect("Main");
                return;
            }
            case "updateUser": {
                // ユーザー編集処理
                String userIdStr = request.getParameter("userId");
                String name = request.getParameter("name");
                String address = request.getParameter("address");
                
                if (userIdStr != null && name != null && address != null) {
                    AdminUserLogic userLogic = new AdminUserLogic();
                    userLogic.updateUser(userIdStr, name, address);
                    // 更新後はユーザー一覧を再表示
                    UsersDAO usersDao = new UsersDAO();
                    List<User> userList = usersDao.findAllUsers();
                    request.setAttribute("userList", userList);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin/admin_UserList.jsp");
                    dispatcher.forward(request, response);
                }
                return;
            }
            case "deleteUser": {
                // ユーザー削除処理
                String userIdStr = request.getParameter("userId");
                if (userIdStr != null && !userIdStr.isEmpty()) {
                    AdminUserLogic userLogic = new AdminUserLogic();
                    userLogic.deleteUser(userIdStr);
                    // 削除後はユーザー一覧を再表示
                    UsersDAO usersDao = new UsersDAO();
                    List<User> userList = usersDao.findAllUsers();
                    request.setAttribute("userList", userList);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin/admin_UserList.jsp");
                    dispatcher.forward(request, response);
                }
                return;
            }
            case "deleteBook": {
                // 本削除処理
                String deleteBookIdStr = request.getParameter("deleteBookId");
                if (deleteBookIdStr != null && !deleteBookIdStr.isEmpty()) {
                    AdminBookLogic bookLogic = new AdminBookLogic();
                    bookLogic.deleteBook(deleteBookIdStr);
                    // 削除後は書籍一覧を表示
                    BooksDAO booksDao = new BooksDAO();
                    List<Book> bookList = booksDao.findAllBooks();
                    request.setAttribute("bookList", bookList);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin/admin_BookList.jsp");
                    dispatcher.forward(request, response);
                }
                return;
            }
            case "updateBook": {
                // 本編集処理
                String bookIdStr = request.getParameter("bookId");
                String title = request.getParameter("title");
                String writer = request.getParameter("writer");
                String company = request.getParameter("company");
                String price = request.getParameter("price");
                String stock = request.getParameter("stock");
                String category = request.getParameter("category");
                String good = request.getParameter("good");

                // 画像ファイルのアップロード処理
                ImageUploadLogic imageLogic = new ImageUploadLogic();
                String imageFileName = null;
                try {
                    jakarta.servlet.http.Part filePart = request.getPart("image");
                    imageFileName = imageLogic.uploadImage(filePart, getServletContext());
                } catch (Exception e) {
                    e.printStackTrace();
                }

                if (bookIdStr != null && title != null && writer != null && company != null && price != null && stock != null) {
                    AdminBookLogic bookLogic = new AdminBookLogic();
                    Book updatedBook = bookLogic.updateBook(bookIdStr, title, writer, company, price, stock, imageFileName, category, good);
                    
                    if (updatedBook != null) {
                        request.setAttribute("message", "商品情報を更新しました");
                    } else {
                        request.setAttribute("message", "商品情報の更新に失敗しました");
                    }
                }
                // 更新後は書籍一覧を表示
                BooksDAO booksDao = new BooksDAO();
                List<Book> bookList = booksDao.findAllBooks();
                request.setAttribute("bookList", bookList);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin/admin_BookList.jsp");
                dispatcher.forward(request, response);
                return;
            }
            case "cancelOrder": {
                // 注文キャンセル処理（管理者用）
                String orderIdStr = request.getParameter("orderid");
                
                if (orderIdStr == null || orderIdStr.isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/Admin?action=orderList&error=orderid");
                    return;
                }
                
                try {
                    int orderId = Integer.parseInt(orderIdStr);
                    dao.OrdersDAO ordersDAO = new dao.OrdersDAO();
                    boolean result = ordersDAO.cancelOrder(orderId);
                    
                    if (result) {
                        response.sendRedirect(request.getContextPath() + "/Admin?action=orderList");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/Admin?action=orderList&error=cancelFail");
                    }
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/Admin?action=orderList&error=orderid");
                }
                return;
            }
            //配送日設定
            case "updateDeliveryDate": {
                String orderIdStr = request.getParameter("orderid");
                String deliveryDateStr = request.getParameter("deliveryDate");

                if (orderIdStr == null || orderIdStr.isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/Admin?action=orderList&error=deliveryDate");
                    return;
                }

                try {
                    int orderId = Integer.parseInt(orderIdStr);
                    java.sql.Date deliveryDate = null;

                    // deliveryDateStr が空でない場合のみ SQL Date に変換
                    if (deliveryDateStr != null && !deliveryDateStr.trim().isEmpty()) {
                        deliveryDate = java.sql.Date.valueOf(deliveryDateStr); // yyyy-MM-dd → SQL Date
                    }

                    OrdersDAO ordersDao = new OrdersDAO();
                    boolean result = ordersDao.updateDeliveryDate(orderId, deliveryDate);

                    // 更新後に全注文を再取得して JSP へ
                    List<Order> orderList = ordersDao.getAllOrder();
                    request.setAttribute("orderList", orderList);

                    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin/admin_OrderList.jsp");
                    dispatcher.forward(request, response);

                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect(request.getContextPath() + "/Admin?action=orderList&error=exception");
                }
                return;
            }
            //配送状態設定
            case "updateDeliveryStatus": {
                String orderIdStr = request.getParameter("orderid");
                String deliveryFlgStr = request.getParameter("deliveryFlg");

                if (orderIdStr == null || deliveryFlgStr == null ||
                    orderIdStr.isEmpty() || deliveryFlgStr.isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/Admin?action=orderList&error=invalidInput");
                    return;
                }

                try {
                    int orderId = Integer.parseInt(orderIdStr);
                    boolean deliveryFlg = Boolean.parseBoolean(deliveryFlgStr);

                    OrdersDAO ordersDao = new OrdersDAO();
                    boolean result = ordersDao.updateDeliveryFlg(orderId, deliveryFlg);

                    // 更新後に全注文を再取得して JSP へ
                    List<Order> orderList = ordersDao.getAllOrder();
                    request.setAttribute("orderList", orderList);

                    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin/admin_OrderList.jsp");
                    dispatcher.forward(request, response);

                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect(request.getContextPath() + "/Admin?action=orderList&error=exception");
                }
                return;
            }
        }
    }
}
