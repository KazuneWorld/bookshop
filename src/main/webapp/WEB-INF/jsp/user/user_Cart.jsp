<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List, model.Book"%>

<%
    // 単一商品ページからの book 属性取得（必要なら使用）
    Book book = (Book) request.getAttribute("book");

    // セッションからカート情報を取得
    List<Book> cart = (List<Book>) session.getAttribute("cart");
%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/user/user_Cart.css">
<link rel="stylesheet" href="css/public/header.css">
<script src="js/header.js"></script>
<title>カート</title>
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

	<main class="main-content">
		<div class="container">
			<h2 class="page-title">ショッピングカート</h2>

			<%-- カートに商品がある場合 --%>
			<% if (cart != null && !cart.isEmpty()) { %>
			<div class="cart-items">
				<table class="cart-table">
					<thead>
						<tr>
							<th class="table-header" colspan="2" >書籍名</th>
							<th class="table-header">数量</th>
							<th class="table-header">単価</th>
							<th class="table-header">操作</th>
						</tr>
					</thead>
					<tbody>
						<%-- for文の変数名を b に変更して重複を回避 --%>
						<% for (Book b : cart) { %>

						<tr class="table-row">

							<td class="book-image">
								<% if (b.getImage() != null && !b.getImage().isEmpty()) { %> <img
								src="<%= request.getContextPath() + "/images/" + b.getImage() %>"
								alt="<%= b.getTitle() %>" class="image"> <% } else { %> <span
								class="no-image">画像はありません</span> <% } %>
							</td>

							<td class="table-cell title"><%= b.getTitle() %></td>

							<td class="table-cell">
								<form action="Cart" method="post" class="quantity-form">
									<input type="hidden" name="bookId" value="<%= b.getBookId() %>">
									<input type="hidden" name="action" value="update">

									<%-- 在庫がある場合のみ数量更新可能 --%>
									<% if (b.getStock() > 0) { %>
									<div class="quantity-group">
										<label for="quantity_<%= b.getBookId() %>"
											class="quantity-label">数量:</label> <input type="number"
											name="quantity" id="quantity_<%= b.getBookId() %>"
											class="quantity-input" value="<%= b.getQuantity() %>" min="1"
											max="<%= Math.min(b.getStock(), 5) %>">
										<button type="submit" class="btn btn-small">更新</button>
									</div>
									<% } else { %>
									<span class="stock-out">在庫切れ</span>
									<% } %>
								</form>
							</td>
							<td class="table-cell"><%= String.format("%,d", b.getPrice()) %>円</td>
							<td class="table-cell">
								<form action="Cart" method="post" class="delete-form">
									<input type="hidden" name="bookId" value="<%= b.getBookId() %>">
									<input type="hidden" name="action" value="delete">
									<button type="submit" class="btn btn-danger-small">削除</button>
								</form>
							</td>
						</tr>
						<% } %>
					</tbody>
				</table>
			</div>

			<%-- 合計金額表示 --%>
			<div class="cart-total">
				<%
				    int total = 0;
				    for (Book b : cart) {
				        total += b.getPrice() * b.getQuantity();
				    }
				%>
				<p class="total-amount">合計: <span class="amount"><%= String.format("%,d", total) %>円</span></p>
			</div>

			<div class="cart-actions">
				<form action="Order" method="get" class="checkout-form">
					<button type="submit" class="btn btn-primary">購入確認へ</button>
				</form>
			</div>

			<% } else { %>
			<%-- カートが空の場合 --%>
			<p class="message message-empty">カートは空です</p>
			<% } %>

			<div class="back-link">
				<a href="Main" class="link">TOPへ戻る</a>
			</div>
		</div>
	</main>
</body>
</html>
