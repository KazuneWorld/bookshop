package model;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

public class Order {

    private int orderId;            // 注文ID
    private int userId;             // ユーザーID
    private String date;            // 注文日
    private List<OrderDetail> orderDetails; // 注文詳細リスト
    private Date deliveryDate;      // 配送日
    private boolean deliveryFlg;    // 配送フラグ

    // コンストラクタ
    public Order(int orderId, int userId, String date) {
        this.orderId = orderId;
        this.userId = userId;
        this.date = date;
    }

    // 注文ID取得
    public int getOrderId() {
        return orderId;
    }

    // ユーザーID取得
    public int getUserId() {
        return userId;
    }

    // 注文日取得
    public String getDate() {
        return date;
    }

    // 注文日（JSP用）
    public String getOrderDate() {
        return date;
    }

    // 注文詳細取得/セット
    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }

    // 配送日取得/セット
    public Date getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(Date deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    // 配送フラグ取得/セット
    public boolean isDeliveryFlg() {
        return deliveryFlg;
    }

    public void setDeliveryFlg(boolean deliveryFlg) {
        this.deliveryFlg = deliveryFlg;
    }

 // 配送日を input type="date" 用の文字列で取得
    public String getDeliveryDateForInput() {
        if (deliveryDate == null) {
            return ""; // null の場合は空文字
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(deliveryDate);
    }
 // JavaBeans 用のプロパティ名は getDeliveryDateInput
    public String getDeliveryDateInput() {
        if (deliveryDate == null) {
            return "";
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(deliveryDate);
    }

    @Override
    public String toString() {
        return "Order [orderId=" + orderId + ", userId=" + userId + ", date=" + date
                + ", deliveryDate=" + deliveryDate + ", deliveryFlg=" + deliveryFlg + "]";
    }
}
