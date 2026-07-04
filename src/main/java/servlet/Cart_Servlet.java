//カート表示・操作用サーブレット
package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Book;
import model.CartLogic;
import model.User;

@WebServlet("/Cart")
public class Cart_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");

        // ログイン必須
        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/Main");
            return;
        }

        // カート表示
        RequestDispatcher dispatcher =
                request.getRequestDispatcher("/WEB-INF/jsp/user/user_Cart.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");

        // ログイン必須
        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/Main");
            return;
        }

        List<Book> cart = (List<Book>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // パラメータ取得
        String action = request.getParameter("action");
        String bookIdStr = request.getParameter("bookId");

        // nullチェック
        if (action == null || bookIdStr == null || bookIdStr.isEmpty()) {
            response.sendRedirect("Cart"); // カート表示に戻す
            return;
        }

        int bookId = Integer.parseInt(bookIdStr);
        CartLogic cartLogic = new CartLogic();

        switch (action) {
            case "add": {
                // フォームから数量取得
                String quantityStr = request.getParameter("quantity");
                int quantity = 1;
                try {
                    quantity = Integer.parseInt(quantityStr);
                } catch (NumberFormatException e) {
                    quantity = 1;
                }

                String message = cartLogic.addToCart(cart, bookId, quantity);
                if (message != null) {
                    request.setAttribute("message", message);
                }
                break;
            }

            case "update": {
                String quantityStrUpdate = request.getParameter("quantity");
                int quantityUpdate = 1;
                try {
                    quantityUpdate = Integer.parseInt(quantityStrUpdate);
                } catch (NumberFormatException e) {
                    quantityUpdate = 1;
                }

                cartLogic.updateCartItem(cart, bookId, quantityUpdate);
                break;
            }

            case "delete": {
                cartLogic.deleteCartItem(cart, bookId);
                break;
            }

            default: 
                response.sendRedirect("Cart");
                return;
        }

        session.setAttribute("cart", cart);

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/user/user_Cart.jsp");
        rd.forward(request, response);
    }
}
