<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/admin/admin_OrderList.css">

<meta charset="UTF-8">
<title>注文一覧（管理者）</title>
</head>
<body>
  <div class="container">
    <h2 class="page-title">注文一覧</h2>

    <div class="order-list">
      <table class="order-table">
        <thead>
          <tr>
            <th class="table-header">注文ID</th>
            <th class="table-header">ユーザーID</th>
            <th class="table-header">注文日</th>
            <th class="table-header">配送日</th>
            <th class="table-header">配送状態</th>
            <th class="table-header">操作</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="order" items="${orderList}">
            <tr class="table-row">
              <td class="table-cell">${order.orderId}</td>
              <td class="table-cell">${order.userId}</td>
              <td class="table-cell">${order.date}</td>

              <!-- 配送日 -->
              <td class="table-cell">
                <form action="${pageContext.request.contextPath}/Admin" method="post" class="delivery-form">
                  <input type="hidden" name="action" value="updateDeliveryDate">
                  <input type="hidden" name="orderid" value="${order.orderId}">

                  <div class="date-group">
                    <!-- DBの配送日を反映 -->
                    <input type="date" name="deliveryDate" class="date-input"
                           value="${order.deliveryDateInput}">

                    <button type="submit" class="btn btn-small btn-primary">更新</button>
                  </div>
                </form>
              </td>

              <!-- 配送状態 -->
              <td class="table-cell">
                <c:choose>
                  <c:when test="${order.deliveryFlg}">
                    <span class="status-badge status-completed">配送完了</span>
                  </c:when>
                  <c:otherwise>
                    <span class="status-badge status-pending">未配送</span>
                  </c:otherwise>
                </c:choose>
              </td>

              <!-- 配送完了状態の切り替え -->
              <td class="table-cell">
                <form action="${pageContext.request.contextPath}/Admin" method="post" class="status-form">
                  <input type="hidden" name="action" value="updateDeliveryStatus">
                  <input type="hidden" name="orderid" value="${order.orderId}">

                  <c:choose>
                    <c:when test="${order.deliveryFlg}">
                      <input type="hidden" name="deliveryFlg" value="false">
                      <button type="submit" class="btn btn-small btn-secondary">未配送に戻す</button>
                    </c:when>
                    <c:otherwise>
                      <input type="hidden" name="deliveryFlg" value="true">
                      <button type="submit" class="btn btn-small btn-success">配送完了</button>
                    </c:otherwise>
                  </c:choose>
                </form>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>

    <div class="back-link">
      <a href="Admin" class="link">戻る</a>
    </div>
  </div>
</body>
</html>
