package model;

public class User {
    private String name;      // ユーザー名
    private String pass;      // パスワード
    private String address;   // メールアドレス
    private int userid;       // ユーザID
    private Integer adminFlg; // 管理者フラグ (0=ユーザー, 1=管理者)

    // フルコンストラクタ（userid, adminFlg含む）
    public User(int userid, String name, String pass, String address, Integer adminFlg) {
        this.userid = userid;
        this.name = name;
        this.pass = pass;
        this.address = address;
        this.adminFlg = adminFlg;
    }

    public User(int userid, String name, String pass, String address) {
        this.userid = userid;
        this.name = name;
        this.pass = pass;
        this.address = address;
    }

    // 新規登録用（userid不要）
    public User(String name, String pass, String address) {
        this.name = name;
        this.pass = pass;
        this.address = address;
    }

    // ログイン用（address不要）
    public User(String name, String pass) {
        this.name = name;
        this.pass = pass;
    }

    // useridのみ用
    public User(int userid) {
        this.userid = userid;
    }


    // ---------- ゲッター ----------
    public String getName() {
        return name;
    }

    public String getPass() {
        return pass;
    }

    public String getAddress() {
        return address;
    }

    public int getUserid() {
        return userid;
    }

    public Integer getAdminFlg() {
        return adminFlg;
    }

    // 権限チェック用のメソッド
    public boolean isUser() {
        return adminFlg != null && adminFlg == 0;
    }

    public boolean isAdmin() {
        return adminFlg != null && adminFlg == 1;
    }


    //---------- セッター ----------
    // メールアドレス変更用
    public void setAddress(String address) {
        this.address = address;
    }

    // パスワード変更用
    public void setPass(String pass) {
        this.pass = pass;
    }

    // 管理者フラグ設定用
    public void setAdminFlg(Integer adminFlg) {
        this.adminFlg = adminFlg;
    }
}