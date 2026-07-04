<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%
//全ユーザーのリストを取得
	List<User> userList = (List<User>)request.getAttribute("userList");
//編集対象のユーザーIDがあるか確認
	String editUserId = request.getParameter("editUserId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/admin/admin_UserList.css">
<title>ユーザー一覧</title>
</head>
<body>
	
<!-- ユーザー一覧 -->
<main class="main-content">
  <div class="container">
    <h2 class="page-title">ユーザー一覧</h2>
    
    <div class="user-list">
      <table class="user-table">
        <thead>
          <tr>
            <th class="table-header">ユーザー名</th>
            <th class="table-header">メールアドレス</th>
            <th class="table-header" colspan="2">操作</th>
          </tr>
        </thead>
        <tbody>
          <%
          // ユーザーリストが存在する場合
          if (userList != null && !userList.isEmpty()) {
            for (User user : userList) {
              String uid = String.valueOf(user.getUserid());
          %>
            <tr class="table-row">
            <% 
            // ここら辺の処理まじでむずかしかった☆
            // パラメータの編集対象のユーザーID(editUserId)と現在のユーザーID(uid)が一致する場合、編集フォームを表示
            if (uid.equals(editUserId)) { %>
              <form action="Admin" method="post" class="edit-form">
                <td class="table-cell">
                  <input type="text" name="name" class="form-input" value="<%= user.getName() %>" required>
                </td>
                <td class="table-cell">
                  <input type="email" name="address" class="form-input" value="<%= user.getAddress() %>" required>
                </td>
                <td class="table-cell" colspan="2">
                  <div class="action-buttons">
                    <input type="hidden" name="action" value="updateUser">
                    <input type="hidden" name="userId" value="<%= user.getUserid() %>">
                    <button type="submit" class="btn btn-small btn-primary">確定</button>
                    <a href="Admin?userList&action=userList">
                      <button type="button" class="btn btn-small btn-secondary">キャンセル</button>
                    </a>
                  </div>
                </td>
              </form>
            <% } else { %>
              <td class="table-cell"><%= user.getName() %></td>
              <td class="table-cell"><%= user.getAddress() %></td>
              <td class="table-cell">
              <% if (user.getAdminFlg() == 0) { %>
                <!-- 編集ボタン（一般ユーザーのみ表示） -->
                <form action="Admin" method="get" class="action-form">
                  <input type="hidden" name="userList" value="">
                  <input type="hidden" name="action" value="userList">
                  <input type="hidden" name="editUserId" value="<%= user.getUserid() %>">
                  <!--編集ボタンが押されたときに編集フォームを表示するためのパラメータを送信-->
                  <button type="submit" class="btn btn-small btn-secondary">編集</button>
                </form>
              <% } %>
              </td>
              <td class="table-cell">
              <% if (user.getAdminFlg() == 0) { %>
                <!-- 退会ボタン（一般ユーザーのみ表示） -->
                <form action="Admin" method="post" class="action-form">
                  <input type="hidden" name="action" value="deleteUser">
                  <input type="hidden" name="userId" value="<%= user.getUserid() %>">
                  <button type="submit" class="btn btn-small btn-danger" onclick="return confirm('このユーザーを本当に退会させますか？');">退会</button>
                </form>
              <% } %>
              </td>
            <% } %>
            </tr>
          <%
            }
          // ユーザーリストが空の場合
          } else {
          %>
            <tr class="table-row">
              <td class="table-cell empty-message" colspan="4">表示できるデータがありません</td>
            </tr>
          <%
          }
          %>
        </tbody>
      </table>
    </div>
    
    <div class="back-link">
      <a href="Admin" class="link">戻る</a>
    </div>
  </div>
</main>
</body>
</html>