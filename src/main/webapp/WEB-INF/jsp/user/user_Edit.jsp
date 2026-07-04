<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.User"%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/user/user_MyPage.css">
<link rel="stylesheet" href="css/public/header.css">
<title>ユーザー情報変更</title>
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

	<%
    User authUser = (User) session.getAttribute("authUser");
    if (authUser == null) {
        response.sendRedirect("Mypage");
        return;
    }
%>
	<main class="main-content">
		<div class="container">
			<h1 class="page-title">変更内容を選択</h1>

			<div class="edit-menu">
				<!-- メールアドレス変更 -->
				<div class="menu-item">
					<a href="Mypage?action=mailEdit">
						<button type="button" class="btn btn-primary">メールアドレス変更</button>
					</a>
				</div>

				<!-- パスワード変更 -->
				<div class="menu-item">
					<a href="Mypage?action=passEdit">
						<button type="button" class="btn btn-primary">パスワード変更</button>
					</a>
				</div>

				<!-- 退会 -->
				<div class="menu-item">
					<a href="Mypage?action=deleteConfirm">
						<button type="button" class="btn btn-delete">退会</button>
					</a>
				</div>
			</div>
		</div>
	</main>
</body>
</html>
