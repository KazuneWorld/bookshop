<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<%
    List<Book> bookList = (List<Book>) request.getAttribute("bookList");
    String keyword = (String) request.getAttribute("keyword");
    String selectedCategory = (String) request.getAttribute("category");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/admin/admin_BookList.css">
<title>書籍一覧表示</title>
</head>
<body>
  <!-- 書籍一覧 -->
  <main class="main-content">
    <div class="container">
      <h2 class="page-title">書籍リスト</h2>
      
      <div class="search-section">
        <form action="Admin" method="get" class="search-form">
          <div class="search-group">
            <select name="category" id="category" class="category-select">
              <option value="" <%= (selectedCategory == null || selectedCategory.isEmpty()) ? "selected" : "" %>>すべて</option>
              <option value="1" <%= "1".equals(selectedCategory) ? "selected" : "" %>>文芸本</option>
              <option value="2" <%= "2".equals(selectedCategory) ? "selected" : "" %>>カレンダー</option>
              <option value="3" <%= "3".equals(selectedCategory) ? "selected" : "" %>>コミック</option>
              <option value="4" <%= "4".equals(selectedCategory) ? "selected" : "" %>>児童本</option>
              <option value="5" <%= "5".equals(selectedCategory) ? "selected" : "" %>>専門書</option>
            </select>
            <input type="hidden" name="action" value="bookList">
            <input type="text" placeholder="リストから検索" name="keyword" class="search-input" value="<%= keyword != null ? keyword : "" %>">
            <button type="submit" class="btn btn-primary">検索</button>
          </div>
        </form>
      </div>
      
      <div class="back-link">
        <a href="Admin" class="link">戻る</a>
      </div>
      
      <div class="book-list">
        <table class="book-table">
          <thead>
            <tr>
              <th class="table-header">カテゴリー</th>
              <th class="table-header">タイトル</th>
              <th class="table-header">著者</th>
              <th class="table-header">出版社</th>
              <th class="table-header">価格</th>
              <th class="table-header">在庫数</th>
              <th class="table-header">操作</th>
            </tr>
          </thead>
          <tbody>
            <%
            // 書籍リストが存在する場合
            if (bookList != null && !bookList.isEmpty()) {
                for (Book book : bookList) {
            %>
              <tr class="table-row">
                <td class="table-cell">
                  <% // カテゴリー表示
                      if(book.getCategory() == 1) { %>
                      文芸本
                  <% } else if(book.getCategory() == 2) { %>
                      カレンダー
                  <% } else if(book.getCategory() == 3) { %>
                      コミック
                  <% } else if(book.getCategory() == 4) { %>
                      児童本
                  <% } else if(book.getCategory() == 5) { %>
                      専門書
                  <% } %>
                </td>
                <td class="table-cell"><%= book.getTitle() %></td>
                <td class="table-cell"><%= book.getWriter() %></td>
                <td class="table-cell"><%= book.getCompany() %></td>
                <td class="table-cell"><%= String.format("%,d", book.getPrice()) %>円</td>
                <td class="table-cell"><%= book.getStock() %>冊</td>
                <td class="table-cell">
                  <!-- 編集ボタン -->
                  <form action="Admin" method="get" class="action-form">
                    <input type="hidden" name="action" value="bookEdit">
                    <input type="hidden" name="bookId" value="<%= book.getBookId() %>">
                    <button type="submit" class="btn btn-small btn-secondary">編集</button>
                  </form>
                </td>
              </tr>
            <%
                }
            } else {
            %>
              <tr class="table-row">
                <td class="table-cell empty-message" colspan="7">書籍は見つかりませんでした</td>
              </tr>
            <%
            }
            %>
          </tbody>
        </table>
      </div>
      
      <div class="back-link">
        <a href="Admin" class="link">戻る</a>
      </div>
    </div>
  </main>
</body>
</html>