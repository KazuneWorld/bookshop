# 書籍ショップ - Book Shopping E-commerce Site

オンライン書籍販売のEコマースサイトです。

## 機能 (Features)

- 📚 書籍カタログの閲覧
- 🔍 書籍詳細情報の表示
- 🛒 ショッピングカート機能
- 💳 チェックアウトプロセス
- 📱 レスポンシブデザイン

## 技術スタック (Tech Stack)

- **Backend**: Node.js + Express
- **Frontend**: HTML5, CSS3, Vanilla JavaScript
- **Storage**: LocalStorage (カート管理)

## セットアップ (Setup)

### 必要な環境 (Requirements)

- Node.js (v20以上)
- npm

### インストール (Installation)

```bash
# 依存関係のインストール
npm install

# サーバーの起動
npm start
```

サーバーは http://localhost:3000 で起動します。

## 使い方 (Usage)

1. ブラウザで http://localhost:3000 にアクセス
2. 書籍一覧から気になる本を選択
3. 「カートに追加」ボタンをクリック
4. カートページで数量を調整
5. 「レジに進む」をクリックしてチェックアウト
6. 配送先情報と支払い方法を入力して注文を完了

## プロジェクト構造 (Project Structure)

```
bookshop/
├── server.js              # Expressサーバー
├── package.json           # プロジェクト設定
├── public/               # 静的ファイル
│   ├── index.html        # ホームページ
│   ├── book.html         # 書籍詳細ページ
│   ├── cart.html         # カートページ
│   ├── checkout.html     # チェックアウトページ
│   ├── css/
│   │   └── style.css     # スタイルシート
│   └── js/
│       ├── cart.js       # カート管理
│       ├── main.js       # ホームページロジック
│       ├── book.js       # 書籍詳細ページロジック
│       ├── cart-page.js  # カートページロジック
│       └── checkout.js   # チェックアウトロジック
└── README.md
```

## API エンドポイント (API Endpoints)

- `GET /api/books` - すべての書籍を取得
- `GET /api/books/:id` - 特定の書籍を取得

## ライセンス (License)

ISC
