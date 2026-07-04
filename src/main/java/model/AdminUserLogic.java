package model;

import dao.UsersDAO;

// 管理者用ユーザー操作ロジッククラス
public class AdminUserLogic {

    // ユーザー情報を更新する
    public boolean updateUser(String userId, String name, String address) {
        try {
            int userIdInt = Integer.parseInt(userId);
            UsersDAO usersDao = new UsersDAO();
            usersDao.updateUser(userIdInt, name, address);
            return true;
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ユーザーを削除する
    public boolean deleteUser(String userId) {
        try {
            int userIdInt = Integer.parseInt(userId);
            UsersDAO usersDao = new UsersDAO();
            usersDao.deleteUser(userIdInt);
            return true;
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return false;
        }
    }
}
