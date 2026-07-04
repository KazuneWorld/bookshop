<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/user/user_MailEdit.css">
<title>パスワード変更</title>
</head>
<body>
  <div class="container">
    <div class="edit-content">
      <h2 class="page-title">パスワード変更</h2>

      <form action="Mypage?action=passUpdate" method="post" class="edit-form">
        <div class="form-group">
          <label for="pass" class="form-label">新しいパスワードを入力</label>
          <input type="password" name="pass" id="pass" class="form-input" required>
        </div>
        
        <div class="form-actions">
          <input type="submit" value="変更" class="btn btn-primary">
        </div>
      </form>

      <div class="back-link">
        <a href="Mypage?action=edit" class="link">戻る</a>
      </div>
    </div>
  </div>
</body>
</html>