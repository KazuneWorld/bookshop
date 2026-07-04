<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/user/user_MailEdit.css">
<title>メールアドレス変更</title>
</head>
<body>
  <div class="container">
    <div class="edit-content">
      <h2 class="page-title">メールアドレス変更</h2>

      <form action="Mypage?action=mailUpdate" method="post" class="edit-form">
        <div class="form-group">
          <label for="address" class="form-label">新しいメールアドレスを入力</label>
          <input type="email" name="address" id="address" class="form-input" required>
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
