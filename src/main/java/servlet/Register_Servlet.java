package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.UsersDAO;
import model.User;

@WebServlet("/Register")
public class Register_Servlet extends HttpServlet {

	
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String pass = request.getParameter("pass");
        String passConfirm = request.getParameter("pass_confirm");
        String address = request.getParameter("address");

        // パスワード一致チェック
        if (pass == null || !pass.equals(passConfirm)) {
            request.setAttribute("error", "パスワードが一致しません");
            request.setAttribute("inputName", name);
            request.setAttribute("inputAddress", address);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        User user = new User(name, pass, address);

        UsersDAO dao = new UsersDAO();
        boolean result = dao.insert(user);

        // 結果で画面を切り替える
        if (result) {
            // 登録成功
            // ログイン不要で直接マイページに遷移
            HttpSession session = request.getSession();
            session.setAttribute("loginUser", user);

            response.sendRedirect("Main");

        } else {
            // 登録失敗 → 登録画面へ戻す
            request.setAttribute("error", "登録に失敗しました。\nその名前またはメールアドレスは既に使用されている可能性があります。");
            request.setAttribute("inputName", name);
            request.setAttribute("inputAddress", address);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}