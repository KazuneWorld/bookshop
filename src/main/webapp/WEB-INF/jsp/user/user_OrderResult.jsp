<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/user/user_OrderResult.css">
<title>購入完了</title>
</head>
<body>
  <div class="container">
    <div class="complete-content">
      <h2 class="complete-title">購入完了</h2>
      <p class="complete-message">購入が完了しました</p>
      
      <div class="complete-actions">
        <!-- 注文履歴へ -->
        <p class="action-item">
          <a href="Mypage?action=history">
            <button class="btn btn-primary">注文履歴を見る</button>
          </a>
        </p>
        <!-- トップへ戻る -->
        <p class="action-item">
          <a href="Main" class="link">買い物を続ける</a>
        </p>
      </div>
    </div>
  </div>
</body>
</html>