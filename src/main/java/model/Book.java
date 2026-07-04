package model;

import java.io.Serializable;

public class Book implements Serializable {

    private int bookId;      // ID
    private String writer;   // 著者名
    private String company;  // 出版社
    private String title;    // タイトル
    private int price;       // 価格
    private int stock;       // 在庫
    private int quantity;    // カート内の数量
    private String image;    // 画像ファイル名
	private int category;    //ジャンルのカテゴリー
	private int good_flg;    //おすすめフラグ

    //---------- コンストラクタ ----------
    public Book() {
    }

    public Book(String title, String writer, String company) {
        this.title = title;
        this.writer = writer;
        this.company = company;
    }

    public Book(int bookId, String title, String writer, String company, int price, int stock) {
        this.bookId = bookId;
        this.title = title;
        this.writer = writer;
        this.company = company;
        this.price = price;
        this.stock = stock;
        
    }

    // 画像ファイル名付きコンストラクタ
    public Book(int bookId, String title, String writer, String company, int price, int stock, String image) {
        this.bookId = bookId;
        this.title = title;
        this.writer = writer;
        this.company = company;
        this.price = price;
        this.stock = stock;
        this.image = image;
        
    }
    
     // カテゴリーつきコンストラクタ
     public Book(int bookId, String title, String writer, String company, int price, int stock, String image, int category) {
        this.bookId = bookId;
        this.title = title;
        this.writer = writer;
        this.company = company;
        this.price = price;
        this.stock = stock;
        this.image = image;
        this.category = category;
        
    }
    
    
    //おすすめフラグつきコンストラクタ
    public Book(int bookId, String title, String writer, String company, int price, int stock, String image, int category,int good_flg) {
    	this.bookId = bookId;
        this.title = title;
        this.writer = writer;
        this.company = company;
        this.price = price;
        this.stock = stock;
        this.image = image;
        this.category = category;
        this.good_flg = good_flg;
	}

	public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    //---------- ゲッター ----------
    public int getBookId() {
        return bookId;
    }

    public String getTitle() {
        return title;
    }

    public String getWriter() {
        return writer;
    }

    public String getCompany() {
        return company;
    }

    public int getPrice() {
        return price;
    }

    public int getStock() {
        return stock;
    }

    public int getQuantity() {
        return quantity;
    }
    
    public int getCategory() {
		return category;
	}
    
    public int getGood_flg() {
		return good_flg;
	}
    

    //---------- セッター ----------
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

	public void setGood_flg(int good_flg) {
		this.good_flg = good_flg;
	}

	
	public void setCategory(int category) {
		this.category = category;
	}

	
	
}