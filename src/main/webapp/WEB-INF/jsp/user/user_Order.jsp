<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.List, java.util.ArrayList, model.Book"%>

<%
    // セッションからカートを取得
    List<Book> cart = (List<Book>) session.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<Book>();
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/user/user_Order.css">
<link rel="stylesheet" href="css/public/header.css">
<script src="js/header.js"></script>
<title>購入確認</title>
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
				<a href="Main"><button>TOP</button></a>
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

	<!-- カート内容 -->
<main class="main-content">
  <div class="container">
    <h2 class="page-title">購入確認</h2>

    <%-- カートに商品が存在する場合 --%>
    <% if (!cart.isEmpty()) { %>
    
      <%-- お届け先情報入力フォーム（ダミー） --%>
      <section class="checkout-section">
        <h3 class="section-title">お届け先情報</h3>
        <div class="checkout-form-container">
          <div class="form-group">
            <label for="postal-code" class="form-label" >郵便番号*</label>
            <div class="postal-code-group">
              <input type="text" id="postal-code" value="100-0001" required>
              <button type="button" class="btn btn-secondary btn-small">住所検索</button>
            </div>
          </div>

          <div class="form-group">
            <label for="prefecture" class="form-label">都道府県*</label>
			<input type="text" id="prefecture" name="prefecture" class="form-input" value="東京都" required>
          </div>

          <div class="form-group">
            <label for="city" class="form-label">市区町村*</label>
            <input type="text" id="city" name="city" class="form-input" value="千代田区" required>
          </div>

          <div class="form-group">
            <label for="address1" class="form-label">町名・番地*</label>
            <input type="text" id="address1" name="address1" class="form-input" value="千代田1-1" required>
          </div>

          <div class="form-group">
            <label for="address2" class="form-label">建物名・部屋番号</label>
            <input type="text" id="address2" name="address2" class="form-input" value="">
          </div>

          <div class="form-group">
            <label for="recipient-name" class="form-label">お名前*</label>
            <input type="text" id="recipient-name" name="recipientName" class="form-input" value="日本 太郎" required>
          </div>

          <div class="form-group">
            <label for="recipient-phone" class="form-label">電話番号*</label>
            <input type="text" id="recipient-phone" name="recipientPhone" class="form-input" value="123-4567-8901" required>
          </div>
        </div>
      </section>

      <%-- お支払い方法選択（ダミーのラジオボタン。クレジットカード,代金引換,銀行振込,コンビニ決済） --%>
	  <section class="checkout-section">
		<h3 class="section-title">お支払い方法</h3>
		<div class="payment-methods">
		  <label class="radio-label">
			<input type="radio" name="paymentMethod" value="creditCard" checked>
			クレジットカード💳
		  </label>
		  <label class="radio-label">
			<input type="radio" name="paymentMethod" value="cod">
			代金引換📦
		  </label>
		  <label class="radio-label">
			<input type="radio" name="paymentMethod" value="bank">
			銀行振込🏦
		  </label>
		  <label class="radio-label">
			<input type="radio" name="paymentMethod" value="conveni">
			コンビニ決済🏪
		  </label>
		</div>
	  </section>

      <%-- クレジットカード情報入力フォーム（ダミー） --%>
      <section class="checkout-section payment-details" id="credit-card-section">
        <h3 class="section-title">
          <span class="payment-icon-title">💳</span>
          クレジットカード情報
        </h3>
        <div class="checkout-form-container">
          <div class="card-brands">
            <!-- <img src="" alt="card-brands" class="card-brand-icon"> -->
          </div>

          <div class="form-group">
            <label for="card-number" class="form-label">カード番号*</label>
            <input type="text" id="card-number" name="cardNumber" class="form-input card-number-input" value="1234 5678 9012 3456" required>
          </div>

          <div class="form-group">
            <label for="card-holder" class="form-label">カード名義*</label>
            <input type="text" id="card-holder" name="cardHolder" class="form-input" value="NOHON TARO" required>
          </div>

          <div class="form-row">
            <div class="form-group form-col">
              <label for="card-expiry" class="form-label">有効期限*</label>
              <input type="text" id="card-expiry" name="cardExpiry" class="form-input" value="02/26" required>
            </div>
            <div class="form-group form-col">
              <label for="card-cvv" class="form-label">セキュリティコード*</label>
              <input type="password" id="card-cvv" name="cardCvv" class="form-input" value="123" required>
            </div>
          </div>
        </div>
      </section>
      </section>
      <hr class="divider">

      <%-- 注文内容確認 --%>
      <section class="checkout-section">
        <h3 class="section-title">ご注文内容</h3>
        <p class="confirm-message">以下の内容で購入を確定しますか？</p>

        <div class="cart-items">
          <table class="cart-table">
            <thead>
              <tr>
                <th class="table-header" colspan="2">書籍名</th>
                <th class="table-header">数量</th>
                <th class="table-header">価格</th>
              </tr>
            </thead>
            <tbody>
              <%-- カート内の書籍を1件ずつ表示 --%>
              <% 
              int total = 0;
              for (Book book : cart) { 
                int subtotal = book.getPrice() * book.getQuantity();
                total += subtotal;
              %>
              <tr class="table-row">
                <td class="table-cell book-image-cell">
                  <% if (book.getImage() != null && !book.getImage().isEmpty()) { %>
                  <img src="<%= request.getContextPath() + "/images/" + book.getImage() %>"
                    alt="<%= book.getTitle() %>" class="cart-book-image">
                  <% } else { %>
                  <span class="no-image">画像なし</span>
                  <% } %>
                </td>
                <td class="table-cell title"><%= book.getTitle() %></td>
                <td class="table-cell"><%= book.getQuantity() %>点</td>
                <td class="table-cell"><%= String.format("%,d", book.getPrice()) %>円</td>
              </tr>
              <% } %>
            </tbody>
          </table>
        </div>

        <%-- 合計金額表示 --%>
        <div class="cart-total">
          <p class="total-amount">合計: <span class="amount"><%= String.format("%,d", total) %>円</span></p>
        </div>


      <%--購入確定ボタン --%>
      <form action="Order" method="post" class="order-form">
        <div class="form-actions">
          <a href="Cart" class="back-to-cart-link">カートに戻る</a>
          <input type="submit" value="注文を確定する" class="btn btn-primary btn-large">
        </div>
      </form>

    <% } else { %>
      <p class="message message-empty">カートは空です</p>
      <div class="back-link">
        <a href="Cart" class="link">カートに戻る</a>
      </div>
    <% } %>
  </div>
</main>


</body>
</html>