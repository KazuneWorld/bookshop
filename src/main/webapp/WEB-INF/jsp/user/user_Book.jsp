<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="model.Book"%>

<%
    Book book = (Book) request.getAttribute("book");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/guest/guest_Book.css">
<link rel="stylesheet" href="css/public/header.css">
<script src="js/header.js"></script>
<title>書籍詳細（ログイン中）</title>
</head>
<body>
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
	<!-- 商品情報 -->
	<main class="main-content">
		<div class="container">
			<div class="book-detail">
				<% if (book != null) { %>

				<div class="book-image">
					<% if (book.getImage() != null && !book.getImage().isEmpty()) { %>
					<img
						src="<%= request.getContextPath() + "/images/" + book.getImage() %>"
						alt="<%= book.getTitle() %>" class="image">
					<% } else { %>
					<span class="no-image">画像はありません</span>
					<% } %>
				</div>

				<div class="book-info">
					<h2 class="book-title"><%= book.getTitle() %></h2>
					<p class="book-meta">
						著者：<%= book.getWriter() %></p>
					<p class="book-meta">
						出版社：<%= book.getCompany() %></p>
					<p class="book-price">
						<%=String.format("%,d", book.getPrice())%>円
					</p>

					<!-- 在庫数が5以下なら残在庫を表示・在庫がなければ在庫切れ表示 -->
					<% if (book.getStock() <= 5) { 
            if (book.getStock() > 0) { %>
					<p class="stock-warning">
						残り<%= book.getStock() %>点
					</p>
					<% } else { %>
					<p class="stock-out">在庫がありません</p>
					<% } %>
					<% } %>

					<form action="Cart" method="post" class="cart-form">
						<input type="hidden" name="action" value="add"> <input
							type="hidden" name="bookId" value="<%= book.getBookId() %>">
						<!-- 個数選択 -->
						<div class="quantity-group">
							<label for="quantity" class="quantity-label">数量:</label> <input
								type="number" id="quantity" name="quantity"
								class="quantity-input" value="1" min="1"
								max="<%= Math.min(book.getStock(), 5) %>">
						</div>
						<div class="book-actions">
							<button type="submit" class="btn btn-cart"
								<% if (book.getStock() == 0) { %> disabled <% } %>>
								カートに追加</button>
						</div>
					</form>
				</div>

				<% } else { %>
				<p class="message message-error">書籍情報が見つかりませんでした。</p>
				<% } %>

			</div>
		</div>
	</main>

</body>
</html>
