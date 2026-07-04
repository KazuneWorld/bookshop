package model;

import dao.UsersDAO;

public class LoginLogic {

	public User execute(User user) {

		//daoの呼び出し
		UsersDAO usersdao = new UsersDAO();
		User returnUser = usersdao.certification(user);

		//認証成功ならtrueを返す
		return returnUser;
	}

}
