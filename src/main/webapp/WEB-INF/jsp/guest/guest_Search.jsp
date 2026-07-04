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
<link rel="stylesheet" href="css/guest/guest_Ad.css">
<script src="js/header.js"></script>
<script src="js/ad_popup.js"></script>
<title>検索結果（ゲストで閲覧中）</title>
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
							<%= (selectedCategory == null || selectedCategory.isEmpty()) ? "selected" : "" %>>すべて</option>
						<option value="1"
							<%= "1".equals(selectedCategory) ? "selected" : "" %>>文芸本</option>
						<option value="2"
							<%= "2".equals(selectedCategory) ? "selected" : "" %>>カレンダー</option>
						<option value="3"
							<%= "3".equals(selectedCategory) ? "selected" : "" %>>コミック</option>
						<option value="4"
							<%= "4".equals(selectedCategory) ? "selected" : "" %>>児童本</option>
						<option value="5"
							<%= "5".equals(selectedCategory) ? "selected" : "" %>>専門書</option>
					</select> <input type="text" placeholder="キーワードで検索" name="keyword"
						value="<%= keyword != null ? keyword : "" %>">
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

	<!-- メイン -->
	<main class="main-content">
		<div class="container">
			<h2 class="page-title">キーワードに関連する商品</h2>

			<!-- 検索結果の表示 -->
			<% if (bookList != null && !bookList.isEmpty()) { %>
			<div class="book-list">
				<% for (Book book : bookList) { %>
				<div class="book-item">
					<a href="Book?bookId=<%= book.getBookId() %>" class="book-link">
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
				<% } %>
			</div>
			<% } else { %>
			<p class="message message-empty">検索結果がありませんでした</p>
			<% } %>
		</div>
	</main>


<!-- ポップアップ広告部分 -->
<!-- オーバーレイ背景 -->
<div id="adOverlay" class="ad-overlay"></div>
<!-- ポップアップモーダル -->
<div id="adPopup" class="ad-popup">
  <div class="ad-popup-content">
	<!-- 広告タイトル -->
    <h2 class="ad-title">さらに多くのコンテンツを見る</h2>
	<!-- 広告説明文 -->
    <p class="ad-description">
      引き続きこのサイトのコンテンツをご覧<br>
      いただくためには、下記のアクションが<br>
      必要です
    </p>
	<!-- 広告アクションボックス -->
    <div class="ad-action-box">
      <div class="ad-action-text">
        <div class="ad-action-title">短い広告を見る</div>
        <div class="ad-action-subtitle">0.024 時間、サイト全体にアクセスできます</div>
      </div>
      <button class="ad-play-button" id="playAdBtn">▶</button>
    </div>
  </div>
</div>
<!-- 広告再生中モーダル -->
<div id="adVideoModal" class="ad-video-modal" style="display: none;">
  <div class="ad-video-content">
    <div class="ad-video-header">
      <span id="adTimer">15 秒後に報酬を獲得できます</span>
    </div>
	<div class="ad-video-area"><a href="https://www.irasutoya.com/" target="_blank">
 		<img src="images/pop_koukokuno_shina.png" alt="広告" class="ad-image">
	</a>
	</div>
  </div>
</div>
<!-- 視聴完了モーダル（閉じるボタン） -->
<div id="adCompleteModal" class="ad-complete-modal" style="display: none;">
  <div class="ad-complete-content">
    <button class="ad-close-button" id="closeAdBtn">×</button>
    <div class="ad-complete-area"><a href="https://www.irasutoya.com/" target="_blank">
      <img src="images/pop_koukokuno_shina.png" alt="広告" class="ad-image">
	</a>
    </div>
  </div>
</div>
</body>
</html>