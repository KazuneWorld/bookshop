<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.Order" %>
<%@ page import="model.OrderDetail" %>
<%@ page import="java.util.List" %>

<%
Order order = (Order) request.getAttribute("order");
List<OrderDetail> details = null;
if(order != null) {
    details = order.getOrderDetails();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/user/user_CancelComplete.css">
<link rel="stylesheet" href="css/public/header.css">
<title>注文キャンセル完了</title>
</head>
<body>
<header>
  <div class="header-container">
    <div class="header-logo-area">
    <div class="header-logo"><a href="Main"><img src="images/BookShop.jpg" alt="BookShop"></a></div>
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
    <div class="cancel-complete-content">
      <h1 class="cancel-complete-title">キャンセル完了</h1>
      <p class="cancel-complete-message">キャンセルしました</p>
      
      <div class="back-link">
        <a href="Mypage?action=history" class="link">戻る</a>
      </div>
    </div>
  </div>
</main>

</body>
</html>
