package model;

import java.util.List;

import dao.UsersDAO;

public class UserListLogic {

	public List<User> execute(){
		UsersDAO dao = new UsersDAO();
		List<model.User> userList = dao.findAllUsers();
		return userList;
	}
}
