<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="model.Book"%>

<%
Book book = (Book) request.getAttribute("book");
%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/guest/guest_Book.css">
<link rel="stylesheet" href="css/public/header.css">
<title>書籍詳細（ゲストで閲覧中）</title>
</head>
<body>

	<!-- 上部 共通部分 -->
	<header>
		<div class="header-container">
			<div class="header-logo-area">
				<div class="header-logo">
					<a href="Main"><img src="images/BookShop.jpg" alt="BookShop"></a>
				</div>
			</div>
			<div class="header-search-area">
				<form action="Book" method="get" class="search-form">
					<select name="category" id="category">
						<option value="" selected>すべて</option>
						<option value="1">文芸本</option>
						<option value="2">カレンダー</option>
						<option value="3">コミック</option>
						<option value="4">児童本</option>
						<option value="5">専門書</option>
					</select> <input type="text" id="keyword" placeholder="キーワードで検索"
						name="keyword">
					<button type="submit">検索</button>
				</form>
			</div>
			<div class="header-buttons-area">
				<div class="Login">
					<a href="login.jsp"><img src="images/ログイン.jpg" alt="Login"></a>
					<span>ログイン</span>
				</div>
				<div class="Register">
					<a href="register.jsp"><img src="images/会員登録.jpg"
						alt="Register"></a> <span>会員登録</span>
				</div>
				<!-- カート（ゲストはログイン画面へ強制） -->
				<div class="Cart">
					<a href="login.jsp?from=notlogin"><img src="images/カート.jpg"
						alt="Cart"></a> <span>カート</span>
				</div>
			</div>
		</div>
		<hr>
	</header>

	<!-- 商品情報 -->
	<main class="main-content">
		<div class="container">
			<div class="book-detail">
				<%
				if (book != null) {
				%>

				<div class="book-image">
					<%
					if (book.getImage() != null && !book.getImage().isEmpty()) {
					%>
					<img
						src="<%=request.getContextPath() + "/images/" + book.getImage()%>"
						alt="<%=book.getTitle()%>" class="image">
					<%
					} else {
					%>
					<span class="no-image">画像はありません</span>
					<%
					}
					%>
				</div>

				<div class="book-info">
					<h2 class="book-title"><%=book.getTitle()%></h2>
					<p class="book-meta">
						著者：<%=book.getWriter()%></p>
					<p class="book-meta">
						出版社：<%=book.getCompany()%></p>
					<p class="book-price">
						<%= String.format("%,d", book.getPrice()) %>円
					</p>

					<!-- 在庫数が5以下なら残在庫を表示・在庫がなければ在庫切れ表示 -->
					<%
					if (book.getStock() <= 5) {
						if (book.getStock() > 0) {
					%>
					<p class="stock-warning">
						残り<%=book.getStock()%>点
					</p>
					<%
					} else {
					%>
					<p class="stock-out">在庫がありません</p>
					<%
					}
					%>
					<%
					}
					%>

					<!-- カートに追加（ゲストはログイン画面へ強制） -->
					<div class="book-actions">
						<a href="login.jsp?from=notlogin" class="cart-link">
							<button class="btn btn-cart" <%if (book.getStock() == 0) {%>
								disabled <%}%>>カートに追加</button>
						</a>
					</div>
				</div>

				<%
				} else {
				%>
				<p class="message message-error">書籍情報が見つかりませんでした。</p>
				<%
				}
				%>

			</div>
		</div>
	</main>

</body>
</html>