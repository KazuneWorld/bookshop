<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/public/login_logout_register.css">
<title>新規会員登録</title>
</head>
<body>
	<div class="container">
		<div class="register-content">
			<h1 class="register-title">新規会員登録</h1>

			<% String error = (String)request.getAttribute("error");
			   if(error != null) { %>
			    <p class="message message-error"><%= error.replace("\n", "<br>") %></p>
			<% } %>

			<form action="Register" method="post" class="register-form">
				<div class="form-section">
					<div class="form-group">
						<label for="name" class="form-label">ユーザー名</label>
						<input type="text" name="name" id="name" class="form-input" required
							value="<%= request.getAttribute("inputName") != null ? request.getAttribute("inputName") : "" %>">
					</div>
					<div class="form-group">
						<label for="address" class="form-label">メールアドレス</label>
						<input type="text" name="address" id="address" class="form-input" required
							value="<%= request.getAttribute("inputAddress") != null ? request.getAttribute("inputAddress") : "" %>">
					</div>
				</div>
				
				<div class="form-password-section">
					<div class="form-group">
						<label for="pass" class="form-label">パスワード</label>
						<input type="password" name="pass" id="pass" class="form-input" required>
					</div>
					<div class="form-group">
						<label for="pass_confirm" class="form-label">パスワード（確認）</label>
						<input type="password" name="pass_confirm" id="pass_confirm" class="form-input" required>
					</div>
				</div>

				<div class="form-actions">
					<input type="submit" value="登録" class="btn btn-primary">
				</div>
			</form>
				<hr class="divider">
			<div class="links">
				<p class="link-item">
					<a href="login.jsp" class="link">ログイン画面へ戻る</a>
				</p>
				<p class="link-item">
					<a href="Main" class="link">トップに戻る</a>
				</p>
			</div>
		</div>
	</div>
</body>
</html>
