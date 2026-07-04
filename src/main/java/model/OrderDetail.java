package model;

public class OrderDetail {

    private String title;   // 商品タイトル
    private double price;   // 価格
    private int quantity;   // 数量
    private int bookId;     // 本のID
    private String image;   // 画像

    // コンストラクタ
    public OrderDetail(String title, double price, int quantity) {
        this.title = title;
        this.price = price;
        this.quantity = quantity;
    }

    //コンストラクタ（人気商品用）
    public OrderDetail(int bookId, String title, String image) {
        this.title = title;
        this.bookId = bookId;
        this.image = image;
    }
    
    // コンストラクタ(画像入り)
    public OrderDetail(String title, double price, int quantity, String image) {
        this.title = title;
        this.price = price;
        this.quantity = quantity;
        this.image = image;
    }
    

    // タイトル取得
    public String getTitle() {
        return title;
    }

    // 価格取得
    public double getPrice() {
        return price;
    }

    // 数量取得
    public int getQuantity() {
        return quantity;
    }

    // 本のID取得
    public int getBookId() {
        return bookId;
    }
    
    // 画像取得
    public String getImage() {
        return image;
    }
    
    @Override
    public String toString() {
        return "OrderDetail [title=" + title + ", price=" + price + ", quantity=" + quantity + ", image=" + image + "]";
    }
}
