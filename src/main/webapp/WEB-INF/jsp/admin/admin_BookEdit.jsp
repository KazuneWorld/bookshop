<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Book"%>
<% Book book=(Book)request.getAttribute("book"); String selectedCategory=String.valueOf(book.getCategory()); %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/admin/admin_BookEdit.css">
<link rel="stylesheet" href="css/public/header.css">
<script src="js/header.js"></script>
<title>商品編集</title>
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

	<!-- 商品編集 -->


	<main class="main-content-edit">
		<div class="container">
			<h2 class="page-title">商品編集</h2>
			<% if (book != null) { %>

			<form action="Admin" method="post" enctype="multipart/form-data"
				class="product-form">
				<input type="hidden" name="action" value="updateBook"> <input
					type="hidden" name="bookId" value="<%= book.getBookId() %>">

				<!-- 画像プレビューと画像アップロード -->
				<div class="form-row">
					<div class="form-group">
						<label class="form-label">現在の画像：</label>
						<div class="current-image">
							<% if (book.getImage() != null && !book.getImage().isEmpty()) { %>
							<div class="image-preview">
								<img
									src="<%= request.getContextPath() + "/images/" + book.getImage() %>"
									alt="<%= book.getTitle() %>" class="preview-image">
							</div>
							<% } else { %>
							<span class="no-image">画像はありません</span>
							<% } %>
						</div>
					</div>

					<div class="form-group form-group-upload">
						<label for="image" class="form-label">画像をアップロード：</label> <input
							type="file" name="image" id="image" class="file-input"
							accept="image/*">
					</div>
				</div>

				<!-- カテゴリとタイトル -->
				<div class="form-row">
					<div class="form-group">
						<label for="category" class="form-label">カテゴリ：</label> <select
							name="category" id="category" class="form-select">
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
						</select>
					</div>

					<div class="form-group">
						<label for="title" class="form-label">タイトル：</label> <input
							type="text" name="title" id="title" class="form-input"
							value="<%= book.getTitle() %>">
					</div>
				</div>

				<!-- 著者と出版社 -->
				<div class="form-row">
					<div class="form-group">
						<label for="writer" class="form-label">著者：</label> <input
							type="text" name="writer" id="writer" class="form-input"
							value="<%= book.getWriter() %>">
					</div>

					<div class="form-group">
						<label for="company" class="form-label">出版社：</label> <input
							type="text" name="company" id="company" class="form-input"
							value="<%= book.getCompany() %>">
					</div>
				</div>

				<!-- 価格と在庫 -->
				<div class="form-row">
					<div class="form-group">
						<label for="price" class="form-label">価格：</label> <input
							type="number" min="0" name="price" id="price" class="form-input"
							value="<%= book.getPrice() %>">
					</div>

					<div class="form-group">
						<label for="stock" class="form-label">在庫：</label> <input
							type="number" min="0" name="stock" id="stock" class="form-input"
							value="<%= book.getStock() %>">
					</div>
				</div>

				<div class="form-group checkbox-group">
					<label class="checkbox-label"> <input type="checkbox"
						name="good" class="checkbox-input"
						<% if (book.getGood_flg() == 1) { %> checked <% } %>>
						トップページにおすすめ表示する
					</label>
				</div>

				<div class="form-actions">
					<input type="submit" value="変更を確定" class="btn btn-primary">
				</div>
			</form>

			<form action="Admin" method="post" class="delete-form"
				onsubmit="return confirm('本当に削除しますか？');">
				<input type="hidden" name="action" value="deleteBook"> <input
					type="hidden" name="deleteBookId" value="<%= book.getBookId() %>">
				<div class="form-actions">
					<input type="submit" value="商品を削除" class="btn btn-danger">
				</div>
			</form>
			<% } else { %>
			<p class="message message-error">商品情報が見つかりません</p>
			<% } %>
			<div class="back-link">
				<a href="Main" class="link">戻る</a>
			</div>



		</div>
	</main>


</body>

</html>