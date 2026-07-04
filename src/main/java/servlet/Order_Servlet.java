package servlet;

import java.io.IOException;
import java.util.ArrayList;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.OrdersDAO;
import model.Book;
import model.User;

@WebServlet("/Order")
public class Order_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.sendRedirect("Login");
            return;
        }

        // カートを取得
        @SuppressWarnings("unchecked")
        java.util.List<Book> cart = (java.util.List<Book>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            request.setAttribute("errorMsg", "カートが空です");
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/user/user_Order.jsp");
            rd.forward(request, response);
            return;
        }

        // 注文登録（カート内の複数商品）
        OrdersDAO ordersDAO = new OrdersDAO();
        boolean success = ordersDAO.insertOrder(loginUser, cart);

        if (success) {
            System.out.println("注文登録成功");
            // 注文完了後はカートを空にする
            session.setAttribute("cart", new ArrayList<Book>());
        } else {
            System.out.println("注文登録失敗");
            request.setAttribute("errorMsg", "注文登録に失敗しました");
        }

        // 購入完了画面に遷移
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/user/user_OrderResult.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // GET は注文確認画面
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/user/user_Order.jsp");
        rd.forward(request, response);
    }
}
