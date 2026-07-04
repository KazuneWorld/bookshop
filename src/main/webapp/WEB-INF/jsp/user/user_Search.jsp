<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Book,java.util.List"%>
<%
List<Book> bookList = (List<Book>) request.getAttribute("bookList");
String selectedCategory = request.getParameter("category");
String keyword = request.getParameter("keyword");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/guest/guest_Search.css">
<link rel="stylesheet" href="css/public/header.css">
<script src="js/header.js"></script>
<title>検索結果（ログイン中）</title>
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
						<option value=""
							<%=(selectedCategory == null || selectedCategory.isEmpty()) ? "selected" : ""%>>すべて</option>
						<option value="1"
							<%="1".equals(selectedCategory) ? "selected" : ""%>>文芸本</option>
						<option value="2"
							<%="2".equals(selectedCategory) ? "selected" : ""%>>カレンダー</option>
						<option value="3"
							<%="3".equals(selectedCategory) ? "selected" : ""%>>コミック</option>
						<option value="4"
							<%="4".equals(selectedCategory) ? "selected" : ""%>>児童本</option>
						<option value="5"
							<%="5".equals(selectedCategory) ? "selected" : ""%>>専門書</option>
					</select> <input type="text" placeholder="キーワードで検索" name="keyword"
						value="<%=keyword != null ? keyword : ""%>">
					<button type="submit">検索</button>
				</form>
			</div>
			<div class="header-buttons-area">
				<div class="Mypage">
					<a href="Mypage"><img src="images/マイページ.jpg" alt="Mypage"></a>
					<span>マイページ</span>
				</div>
				<div class="Cart">
					<a href="Cart"><img src="images/カート.jpg" alt="Cart"></a> <span>カート</span>
				</div>
				<div class="Logout">
					<a href="Logout"><img src="images/ログアウト.jpg" alt="Logout"></a>
					<span>ログアウト</span>
				</div>
			</div>
		</div>
		<hr>
	</header>

	<!-- メイン -->
	<main class="main-content">
		<div class="container">
			<h2 class="page-title">キーワードに関連する商品</h2>

			<!-- 検索結果の表示 -->
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
					</a>
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
			<p class="message message-empty">検索結果がありませんでした</p>
			<%
			}
			%>
		</div>
	</main>

</body>
</html>