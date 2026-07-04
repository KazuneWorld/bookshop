<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="css/admin/admin_BookEdit.css">
		<title>書籍の新規登録</title>
	</head>

<body>
  <!-- 新商品追加 -->
  <main class="main-content-newbook">
    <div class="container">
      <h2 class="page-title">新商品追加</h2>

      <form action="Admin" method="post" enctype="multipart/form-data" class="product-form">
          <div class="form-row">
            <div class="form-group">
              <%-- 時間あればjsで画像プレビュー実装 --%>
            </div>
            <div class="form-group form-group-upload">
              <label for="image" class="form-label">商品画像：</label>
              <input type="file" name="image" id="image" class="file-input" accept="image/*">
            </div>
          </div>
        
        <input type="hidden" name="action" value="add">
        
        <div class="form-row">
          <div class="form-group">
            <label for="category" class="form-label">カテゴリ：</label>
            <select name="category" id="category" class="form-select" required>
              <option value="">選択してください</option>
              <option value="1">文芸本</option>
              <option value="2">カレンダー</option>
              <option value="3">コミック</option>
              <option value="4">児童本</option>
              <option value="5">専門書</option>
            </select>
          </div>
          <div class="form-group">
            <label for="title" class="form-label">名前：</label>
            <input type="text" name="title" id="title" class="form-input" required>
          </div>
        </div>
        <div class="form-row">
          <div class="form-group">
            <label for="writer" class="form-label">著者：</label>
            <input type="text" name="writer" id="writer" class="form-input" required>
          </div>
          <div class="form-group">
            <label for="company" class="form-label">出版社：</label>
            <input type="text" name="company" id="company" class="form-input" required>
          </div>
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <label for="price" class="form-label">価格：</label>
            <input type="number" min="0" name="price" id="price" class="form-input" required>
          </div>
          <div class="form-group">
            <label for="stock" class="form-label">在庫：</label>
            <input type="number" min="0" name="stock" id="stock" class="form-input" required>
          </div>
        </div>

        <div class="form-group checkbox-group">
          <label class="checkbox-label">
            <input type="checkbox" name="good" class="checkbox-input">
            トップページにおすすめ表示する
          </label>
        </div>

        <div class="form-actions">
          <input type="submit" value="商品を追加" class="btn btn-primary">
        </div>

        <div class="back-link">
          <a href="Admin" class="link">戻る</a>
        </div>
      </form>
    </div>
  </main>
</body>
	</html>