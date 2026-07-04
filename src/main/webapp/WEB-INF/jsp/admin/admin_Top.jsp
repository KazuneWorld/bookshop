<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.User,model.Book,java.util.List"%>
<%
User loginUser = (User) session.getAttribute("loginUser");
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
<title>TOP（管理者でログイン中）</title>
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
					</select>
					<input type="text" id="keyword" placeholder="キーワードで検索" name="keyword">
					<button type="submit">検索</button>
				</form>
			</div>
			<div class="header-buttons-area">
				<div class="Admin">
					<a href="Admin"><img src="images/管理者ページ.jpg" alt="Admin"></a>
					<span>管理者ページ</span>
				</div>
				<div class="Logout">
					<a href="Logout"><img src="images/ログアウト.jpg" alt="Logout"></a>
					<span>ログアウト</span>
				</div>
			</div>
		</div>
		<hr>
	</header>

	<!-- 管理者TOP内容 -->
	<main class="main-content">
		<div class="container">
			<p class="admin-status">管理者としてログイン中</p>

			<!-- 人気ランキングTOP5 -->
			<h2 class="section-title">人気ランキングTOP5</h2>
			<% if (topBooks != null && !topBooks.isEmpty()) { %>
			<div class="top-books-list">

				<% int rank = 1; %>

				<% for (model.OrderDetail orderDetail : topBooks) { %>
				<div class="top-book-item">

					<!-- ★順位画像 -->
					<div class="rank-badge">
						<img src="<%=request.getContextPath()%>/images/rank<%=rank%>.png"
							alt="<%=rank%>位">
					</div>

					<a
						href="Admin?bookId=<%= orderDetail.getBookId() %>&action=bookEdit"
						class="top-book-link">
						<div class="top-book-image">
							<% if (orderDetail.getImage() != null && !orderDetail.getImage().isEmpty()) { %>
							<img
								src="<%= request.getContextPath() + "/images/" + orderDetail.getImage() %>"
								alt="<%= orderDetail.getTitle() %>" class="image">
							<% } else { %>
							<span class="no-image">画像はありません</span>
							<% } %>
						</div>
					</a>
					<a
						href="Admin?bookId=<%= orderDetail.getBookId() %>&action=bookEdit"
						class="top-book-title-link">
						<p class="top-book-title"><%= orderDetail.getTitle() %></p>
					</a>
				</div>

				<% rank++; %>

				<% } %>
			</div>
			<% } else { %>
			<p class="message message-empty">人気ランキングのデータがありません</p>
			<% } %>

			<h2 class="section-title">設定中のおすすめ商品</h2>

			<% if (bookList != null && !bookList.isEmpty()) { %>
			<div class="book-list">
				<% for (Book book : bookList) { %>
				<div class="book-item">
					<a href="Admin?bookId=<%= book.getBookId() %>&action=bookEdit"
						class="book-link">
						<div class="book-image">
							<% if (book.getImage() != null && !book.getImage().isEmpty()) { %>
							<img
								src="<%= request.getContextPath() + "/images/" + book.getImage() %>"
								alt="<%= book.getTitle() %>" class="image">
							<% } else { %>
							<span class="no-image">画像はありません</span>
							<% } %>
						</div>
					</a>
					<div class="book-info">
						<a href="Admin?bookId=<%=book.getBookId()%>&action=bookEdit"
							class="book-title-link">
							<p class="book-title"><%=book.getTitle()%></p>
						</a>
						<p class="book-writer">著者：<%=book.getWriter()%></p>
						<p class="book-company">出版社：<%=book.getCompany()%></p>
						<p class="book-price"><%= String.format("%,d", book.getPrice()) %>円</p>
					</div>
				</div>
				<% } %>
			</div>
			<% } else { %>
			<p class="message message-empty">
				おすすめに設定されている商品がありません。<br>おすすめを設定してください。
			</p>
			<% } %>

		</div>
	</main>

</body>
</html>
