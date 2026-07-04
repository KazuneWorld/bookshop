<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="model.User,model.Order,model.OrderDetail,java.util.List"%>

<%
User loginUser = (User) session.getAttribute("loginUser");
List<Order> orderList = (List<Order>) request.getAttribute("orderList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/user/user_History.css">
<link rel="stylesheet" href="css/public/header.css">
<script src="js/header.js"></script>
<title>注文履歴</title>
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
			<h2 class="page-title">注文履歴</h2>

			<%-- 注文履歴がある場合 --%>
			<% if (orderList != null && !orderList.isEmpty()) { %>
			<div class="order-list">
				<%-- 履歴1件ずつ表示 --%>
				<% for (Order order : orderList) { %>
				<div class="order-item">
					<div class="order-summary">

						<!-- 注文ID -->
						<p class="order-info-item">
							注文ID：<%= order.getOrderId() %></p>
						<!-- 日付 -->
						<p class="order-info-item">
							日付：<%= order.getDate() %></p>
						<!-- 商品タイトル -->
						<div class="book-titles">
							<%
				// 注文詳細リスト取得
                  List<OrderDetail> detailList = order.getOrderDetails();
                  if (detailList != null && !detailList.isEmpty()) {
                    OrderDetail firstDetail = detailList.get(0);
                    int totalCount = detailList.size();
                %>
							<span class="title-item">
								<%-- 最初の商品のタイトル表示。他に商品があれば「他XX点」と表示 --%>
								<strong><%= firstDetail.getTitle() %></strong>
								<% if (totalCount > 1) { %>
								他<%= totalCount - 1 %>点
								<% } %>
							</span>
							<% } %>
						</div>

					</div>

					<div class="order-actions">
						<a href="Mypage?action=receipt&orderId=<%= order.getOrderId() %>">
							<button class="btn btn-secondary">詳細</button>
						</a>
					</div>
				</div>

				<hr class="divider">
				<% } %>
				<%-- for 終了 --%>
			</div>

			<% } else { %>
			<p class="message message-empty">注文履歴はありません</p>
			<% } %>
			<%-- if 終了 --%>

			<div class="back-link">
				<a href="Mypage" class="link">戻る</a>
			</div>
		</div>
	</main>
</body>
</html>
