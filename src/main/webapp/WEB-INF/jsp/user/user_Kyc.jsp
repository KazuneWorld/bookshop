<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/user/user_Kyc.css">
<title>本人確認</title>
</head>
<body>
  <div class="container">
    <div class="kyc-content">
      <h1 class="kyc-title">本人確認</h1>
      <p class="kyc-message">パスワードを入力してください</p>
      <% String error = (String) request.getAttribute("error"); %>
      <% if (error != null) { %>
        <p class="message message-error"><%= error %></p>
      <% } %>

      <form action="Mypage?action=kyc" method="post" class="kyc-form">
        <div class="form-group">
          <label for="pass" class="form-label">パスワード</label>
          <input type="password" name="pass" id="pass" class="form-input" required>
        </div>

        <div class="form-actions">
          <input type="submit" value="確認" class="btn btn-primary">
        </div>
      </form>
    </div>
  </div>
</body>
</html>
