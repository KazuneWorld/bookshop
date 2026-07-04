package model;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class UserPageSelector {

	public void prepareMainPageData(HttpServletRequest request) {
    	HttpSession session = request.getSession();
    	User loginUser = (User) session.getAttribute("loginUser");

    	String jspPath;

    	if (loginUser == null) {
    	    // ログインしていない = ゲスト
    	    jspPath = "/WEB-INF/jsp/guest/guest_Top.jsp";
    	} else if (loginUser.isAdmin()) {
    	    // admin_flg = 1 = 管理者
    	    jspPath = "/WEB-INF/jsp/admin/admin_Top.jsp";
    	} else {
    	    // admin_flg = 0 = 一般ユーザー
    	    jspPath = "/WEB-INF/jsp/user/user_Top.jsp";
    	}

    	request.setAttribute("jspPath", jspPath);
	}
}