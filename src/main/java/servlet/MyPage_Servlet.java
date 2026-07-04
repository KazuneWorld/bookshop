// マイページ表示・本人確認・ユーザー情報編集・注文履歴表示を行うサーブレット
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

import dao.Order_DetailDAO;
import dao.UsersDAO;
import model.Order;
import model.User;

@WebServlet("/Mypage")
public class MyPage_Servlet extends HttpServlet {
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

        String action = request.getParameter("action");
        String forwardPath = null;

        if (action == null) {
            action = "";
        }

        switch (action) {
            case "kyc": {
                // 本人確認画面表示
                forwardPath = "/WEB-INF/jsp/user/user_Kyc.jsp";
                break;
            }

            case "edit": {
                // ユーザー編集画面表示
                // 本人確認済みかチェック
                User authUser = (User) session.getAttribute("authUser");
                if (authUser == null) {
                    response.sendRedirect("Mypage?action=kyc");
                    return;
                }
                forwardPath = "/WEB-INF/jsp/user/user_Edit.jsp";
                break;
            }

            case "mailEdit": {
                // メール変更画面表示
                // 本人確認済みかチェック
                User authUser = (User) session.getAttribute("authUser");
                if (authUser == null) {
                    response.sendRedirect("Mypage?action=kyc");
                    return;
                }
                forwardPath = "/WEB-INF/jsp/user/user_MailEdit.jsp";
                break;
            }

            case "passEdit": {
                // パスワード変更画面表示
                // 本人確認済みかチェック
                User authUser = (User) session.getAttribute("authUser");
                if (authUser == null) {
                    response.sendRedirect("Mypage?action=kyc");
                    return;
                }
                forwardPath = "/WEB-INF/jsp/user/user_PassEdit.jsp";
                break;
            }

            case "history": {
                // 注文履歴表示
                Order_DetailDAO historyDAO = new Order_DetailDAO();
                List<Order> historyList = historyDAO.getMyOrders(loginUser);
                request.setAttribute("orderList", historyList);
                forwardPath = "/WEB-INF/jsp/user/user_History.jsp";
                break;
            }

            case "receipt": {
                // 注文詳細（レシート）表示
                String strOrderId = request.getParameter("orderId");
                if (strOrderId == null || strOrderId.isEmpty()) {
                    response.sendRedirect("Mypage?action=history");
                    return;
                }

                int orderId = Integer.parseInt(strOrderId);

                // DAOから注文情報を取得
                Order_DetailDAO dao = new Order_DetailDAO();
                List<Order> orderList = dao.getMyOrders(loginUser);

                // orderId に一致する Order を探す
                Order targetOrder = null;
                for(Order o : orderList) {
                    if(o.getOrderId() == orderId) {
                        targetOrder = o;
                        break;
                    }
                }

                if(targetOrder == null) {
                    response.sendRedirect("Mypage?action=history");
                    return;
                }

                // JSPにセット
                request.setAttribute("order", targetOrder);
                forwardPath = "/WEB-INF/jsp/user/user_Receipt.jsp";
                break;
            }

            case "deleteConfirm": {
                // 退会確認画面表示
                forwardPath = "/WEB-INF/jsp/user/user_Delete.jsp";
                break;
            }

            default: {
                // マイページ表示
                forwardPath = "/WEB-INF/jsp/user/user_MyPage.jsp";
                break;
            }
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(forwardPath);
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");

        // ログイン必須
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if (action == null) {
            action = "";
        }

        switch (action) {
            case "kyc": {
                // 本人確認処理
                String pass = request.getParameter("pass");
                UsersDAO dao = new UsersDAO();
                User user = dao.findByNameAndPass(loginUser.getName(), pass);

                if (user != null) {
                    // 本人確認OK
                    session.setAttribute("authUser", user);
                    request.getRequestDispatcher("/WEB-INF/jsp/user/user_Edit.jsp")
                           .forward(request, response);
                } else {
                    // パスワード違い
                    request.setAttribute("error", "パスワードが違います");
                    request.getRequestDispatcher("/WEB-INF/jsp/user/user_Kyc.jsp")
                           .forward(request, response);
                }
                break;
            }

            case "mailUpdate": {
                // メール更新処理
                User authUser = (User) session.getAttribute("authUser");
                if (authUser == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }

                String address = request.getParameter("address");
                UsersDAO dao = new UsersDAO();
                dao.updateMail(authUser.getName(), address);

                // セッションの情報も更新
                authUser.setAddress(address);
                session.setAttribute("authUser", authUser);

                // 編集画面に戻す
                response.sendRedirect("Mypage?action=edit");
                break;
            }

            case "passUpdate": {
                // パスワード更新処理
                User authUser = (User) session.getAttribute("authUser");
                if (authUser == null) {
                    response.sendRedirect("Mypage");
                    return;
                }

                String newPass = request.getParameter("pass");
                UsersDAO dao = new UsersDAO();
                dao.updatePass(authUser.getName(), newPass);

                // セッションも更新
                authUser.setPass(newPass);

                response.sendRedirect("Mypage");
                break;
            }

            case "deleteUser": {
                // 退会処理
                UsersDAO usersDAO = new UsersDAO();
                usersDAO.deleteUser(loginUser.getUserid());

                // セッションスコープを破棄
                session.invalidate();

                request.getRequestDispatcher("/WEB-INF/jsp/user/user_DeleteComplete.jsp")
                       .forward(request, response);
                return;
            }

            case "cancel": {
                // 注文キャンセル処理
                String orderIdStr = request.getParameter("orderid");
                
                if (orderIdStr == null || orderIdStr.isEmpty()) {
                    response.sendRedirect("Mypage?action=history&error=orderid");
                    return;
                }
                
                int orderId;
                try {
                    orderId = Integer.parseInt(orderIdStr);
                } catch (NumberFormatException e) {
                    response.sendRedirect("Mypage?action=history&error=orderid");
                    return;
                }
                
                // キャンセル処理
                dao.OrdersDAO ordersDAO = new dao.OrdersDAO();
                boolean result = ordersDAO.cancelOrder(orderId);
                
                if (result) {
                    // キャンセル完了ページへ
                    request.getRequestDispatcher("/WEB-INF/jsp/user/user_CancelComplete.jsp")
                           .forward(request, response);
                } else {
                    // 失敗したら注文履歴へ
                    response.sendRedirect("Mypage?action=history&error=cancelFail");
                }
                break;
            }

            default:
                response.sendRedirect("Mypage");
                break;
        }
    }
}
