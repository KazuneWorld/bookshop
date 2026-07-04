<%--  URLの末尾にファイル名を指定しなくても
呼び出せる、デフォルトページ--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/public/login_logout_register.css">
<title>ログイン</title>
</head>
<body>
	<div class="container">
		<div class="login-content">
			<h1 class="login-title">ログイン</h1>

			<!-- ログイン失敗時のエラーメッセージ表示 -->
			<%
			String errorMsg = (String)request.getAttribute("errorMsg");
			String from = request.getParameter("from");
			if (errorMsg != null) {
			%>
			<p class="message message-error"><%= errorMsg %></p>
			<%
			}
			// ゲストが利用できないボタンから遷移してきた場合のメッセージ表示
			if ("notlogin".equals(from)) {
			%>
			<p class="message message-info">この機能を利用するにはログインが必要です</p>
			<%
			}
			%>

			<form action="Login" method="post" class="login-form">
				<div class="form-group">
					<label for="name" class="form-label">ユーザー名またはメールアドレス</label>
					<input type="text" name="name" id="name" class="form-input"
						value="<%= request.getAttribute("inputName") != null ? request.getAttribute("inputName") : "" %>">
				</div>

				<div class="form-group">
					<label for="pass" class="form-label">パスワード</label>
					<input type="password" name="pass" id="pass" class="form-input">
				</div>

				<div class="form-actions">
					<input type="submit" value="ログイン" class="btn btn-primary">
				</div>

				<hr class="divider">

				<div class="link-others">
					<div class="register-link">未登録の方は
						<a href="register.jsp" class="link">こちら</a>
						から会員登録してください
					</div>
					<div class="link-item"><a href="Main" class="link">戻る</a>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>