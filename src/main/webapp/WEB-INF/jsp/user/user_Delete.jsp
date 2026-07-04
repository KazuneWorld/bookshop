<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/user/user_Delete.css">
<title>退会確認</title>
</head>
<body>
  <div class="container">
    <div class="delete-content">
      <h2 class="delete-title">退会確認</h2>
      
      <form action="Mypage?action=deleteUser" method="post" class="delete-form">
        <p class="delete-message">退会しますか</p>
        
        <div class="form-actions">
          <input type="submit" value="退会する" class="btn btn-danger" onclick="return confirm('本当によろしいですか？');">
        </div>
      </form>
      
      <hr class="divider">

      <div class="back-link">
        <a href="Mypage?action=edit" class="link">戻る</a>
      </div>
    </div>
  </div>
</body>
</html>