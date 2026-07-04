<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/user/user_MyPage.css">
<link rel="stylesheet" href="css/public/header.css">
<title>管理者ページ</title>
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

	<!-- 管理者ページ内容 -->
	<main class="main-content">
		<div class="container">
			<h2 class="page-title">管理者ページ</h2>

			<div class="admin-menu">
				<div class="menu-item">
					<a href="Admin?action=bookAdd">
						<button class="btn btn-primary">新商品の追加</button>
					</a>
				</div>

				<div class="menu-item">
					<a href="Admin?action=bookList">
						<button class="btn btn-primary">書籍一覧</button>
					</a>
				</div>

				<div class="menu-item">
					<a href="Admin?userList&action=userList">
						<button class="btn btn-primary">ユーザー一覧</button>
					</a>
				</div>

				<div class="menu-item">
					<a href="Admin?orderList&action=orderList">
						<button class="btn btn-primary">注文一覧</button>
					</a>
				</div>
			</div>
		</div>
	</main>

</body>
</html>
