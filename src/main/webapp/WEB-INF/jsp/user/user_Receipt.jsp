<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Order"%>
<%@ page import="model.OrderDetail"%>
<%@ page import="java.util.List"%>

<%
Order order = (Order) request.getAttribute("order");
List<OrderDetail> details = null;
if (order != null) {
	details = order.getOrderDetails();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>注文詳細</title>


<link rel="stylesheet" href="css/user/user_Receipt.css">
<link rel="stylesheet" href="css/public/header.css">
<script src="js/header.js"></script>
</head>

<body>
	<header>
		<div class="header-container">
			<div class="header-logo-area">
				<div class="header-logo">
					<a href="Main">
						<img src="images/BookShop.jpg" alt="BookShop">
					</a>
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
				<div class="Mypage">
					<a href="Mypage"><img src="images/マイページ.jpg"></a>
					<span>マイページ</span>
				</div>
				<div class="Cart">
					<a href="Cart"><img src="images/カート.jpg"></a>
					<span>カート</span>
				</div>
				<div class="Logout">
					<a href="Logout"><img src="images/ログアウト.jpg"></a>
					<span>ログアウト</span>
				</div>
			</div>
		</div>
		<hr>
	</header>

	<main class="main-content">
		<div class="container">

		<% if (order != null) { %>

			<h2 class="page-title">注文詳細</h2>

			<div class="order-info">
				<p class="order-info-item">注文ID：<%= order.getOrderId() %></p>
				<p class="order-info-item">注文日：<%= order.getDate() %></p>

				<%
				String deliveryLabel;
				if (order.isDeliveryFlg()) {
					deliveryLabel = "配送済み";
				} else if (order.getDeliveryDate() != null) {
					deliveryLabel = "配送予定日：" + order.getDeliveryDateInput();
				} else {
					deliveryLabel = "準備中";
				}
				%>

				<p class="order-info-item">配送状況：<%= deliveryLabel %></p>
			</div>

			<h3 class="section-title">商品一覧</h3>

			<%
			if (details != null && !details.isEmpty()) {
				double total = 0;
			%>

			<div class="order-items">

				<div class="order-header">
					<div class="col-book">書籍名</div>
					<div class="col-price">価格</div>
					<div class="col-qty">数量</div>
					<div class="col-subtotal">小計</div>
				</div>

				<%
				for (OrderDetail d : details) {
					double subtotal = d.getPrice() * d.getQuantity();
					total += subtotal;
				%>

				<div class="order-row">
					<div class="col-book book-info">
						<% if (d.getImage() != null && !d.getImage().isEmpty()) { %>
							<img src="<%= request.getContextPath() + "/images/" + d.getImage() %>"
							     class="book-image">
						<% } %>
						<span><%= d.getTitle() %></span>
					</div>
					<div class="col-price"><%= String.format("%,d", (int)d.getPrice()) %>円</div>
					<div class="col-qty"><%= d.getQuantity() %></div>
					<div class="col-subtotal"><%= String.format("%,d", (int)subtotal) %>円</div>
				</div>

				<% } %>

				<div class="order-total">
					合計：<span><%= String.format("%,d", (int)total) %>円</span>
				</div>

			</div>

			<% } else { %>
				<p>注文商品の情報がありません</p>
			<% } %>

			<% if (!order.isDeliveryFlg()) { %>
				<h4 class="cancel-title">この注文をキャンセル</h4>
				<form action="Mypage" method="post">
					<input type="hidden" name="action" value="cancel">
					<input type="hidden" name="orderid" value="<%= order.getOrderId() %>">
					<input type="submit" value="キャンセル" class="btn btn-danger"
						onclick="return confirm('本当によろしいですか？');">
				</form>
			<% } %>

		<% } else { %>
			<p>注文情報が見つかりません</p>
		<% } %>

			<div class="back-link">
				<a href="Mypage?action=history">戻る</a>
			</div>

		</div>
	</main>

</body>
</html>
