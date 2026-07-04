<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Book,java.util.List"%>
<%
List<Book> bookList = (List<Book>) request.getAttribute("bookList");
List<model.OrderDetail> topBooks = (List<model.OrderDetail>) request.getAttribute("topBooks");
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/guest/guest_Top.css">
<link rel="stylesheet" href="css/public/header.css">
<script src="js/header.js"></script>
<title>TOP（ゲストで閲覧中）</title>
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
					<a href="register.jsp"><img src="images/会員登録.jpg" alt="Register"></a>
					<span>会員登録</span>
				</div>
				<!-- カート（ゲストはログイン画面へ強制） -->
				<div class="Cart">
					<a href="login.jsp?from=notlogin"><img src="images/カート.jpg" alt="Cart"></a>
					<span>カート</span>
				</div>
			</div>
		</div>
		<hr>
	</header>

	<!-- メイン -->
	<main class="main-content">
		<div class="container">
			<p class="welcome-message">ゲストさん、ようこそ</p>
			<!-- 人気ランキングTOP5 -->
			<h2 class="section-title">人気ランキングTOP5</h2>
			<%
			if (topBooks != null && !topBooks.isEmpty()) {
			%>
			<div class="top-books-list">
				<%
				int rank = 1;
				%>
				<%
				for (model.OrderDetail orderDetail : topBooks) {
				%>
				<div class="top-book-item">

					<!-- ★ここ：順位画像 -->
					<div class="rank-badge">
						<img src="<%=request.getContextPath()%>/images/rank<%=rank%>.png"
							alt="<%=rank%>位">
					</div>

					<a href="Book?bookId=<%=orderDetail.getBookId()%>"
						class="top-book-link">
						<div class="top-book-image">
							<%
							if (orderDetail.getImage() != null && !orderDetail.getImage().isEmpty()) {
							%>
							<img
								src="<%=request.getContextPath() + "/images/" + orderDetail.getImage()%>"
								alt="<%=orderDetail.getTitle()%>" class="image">
							<%
							} else {
							%>
							<span class="no-image">画像はありません</span>
							<%
							}
							%>
						</div>
					</a> <a href="Book?bookId=<%=orderDetail.getBookId()%>"
						class="top-book-title-link">
						<p class="top-book-title"><%=orderDetail.getTitle()%></p>
					</a>

				</div>

				<%
				rank++;
				%>
				<%
				}
				%>
			</div>
			<%
			} else {
			%>
			<p class="message message-empty">人気ランキングのデータがありません</p>
			<%
			}
			%>
			<h2 class="section-title">おすすめ商品</h2>

			<%
			if (bookList != null && !bookList.isEmpty()) {
			%>
			<div class="book-list">
				<%
				for (Book book : bookList) {
				%>
				<div class="book-item">
					<a href="Book?bookId=<%=book.getBookId()%>" class="book-link">
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
							<a href="Book?bookId=<%=book.getBookId()%>"
								class="book-title-link">
								<p class="book-title"><%=book.getTitle()%></p>
							</a>
							<p class="book-writer">
								著者：<%=book.getWriter()%></p>
							<p class="book-company">
								出版社：<%=book.getCompany()%></p>
							<p class="book-price">
								<%= String.format("%,d", book.getPrice()) %>円
							</p>

						</div>
				</div>
				<%
				}
				%>
			</div>
			<%
			} else {
			%>
			<p class="message message-empty">書籍がありません</p>
			<%
			}
			%>

		</div>
	</main>
</body>
</html>