const express = require('express');
const path = require('path');
const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.json());
app.use(express.static('public'));

// Sample book data
const books = [
  {
    id: 1,
    title: 'JavaScript入門',
    author: '山田太郎',
    price: 2980,
    description: '初心者向けのJavaScript入門書です。基礎から応用まで丁寧に解説しています。',
    image: '/images/book1.jpg',
    stock: 15
  },
  {
    id: 2,
    title: 'Pythonプログラミング',
    author: '鈴木花子',
    price: 3200,
    description: 'Python言語の基本から実践的な応用まで学べる一冊です。',
    image: '/images/book2.jpg',
    stock: 20
  },
  {
    id: 3,
    title: 'Webデザインの教科書',
    author: '佐藤健一',
    price: 2500,
    description: '美しいWebサイトを作るためのデザイン原則とテクニックを解説。',
    image: '/images/book3.jpg',
    stock: 10
  },
  {
    id: 4,
    title: 'データベース設計入門',
    author: '田中美咲',
    price: 3500,
    description: 'データベースの基礎から設計手法まで網羅的に学べます。',
    image: '/images/book4.jpg',
    stock: 8
  },
  {
    id: 5,
    title: 'モバイルアプリ開発',
    author: '高橋誠',
    price: 3800,
    description: 'iOSとAndroidの両方に対応したモバイルアプリ開発ガイド。',
    image: '/images/book5.jpg',
    stock: 12
  },
  {
    id: 6,
    title: 'AI・機械学習の基礎',
    author: '小林由美',
    price: 4200,
    description: '人工知能と機械学習の基本概念を分かりやすく解説。',
    image: '/images/book6.jpg',
    stock: 18
  }
];

// API endpoints
app.get('/api/books', (req, res) => {
  res.json(books);
});

app.get('/api/books/:id', (req, res) => {
  const book = books.find(b => b.id === parseInt(req.params.id));
  if (book) {
    res.json(book);
  } else {
    res.status(404).json({ error: '書籍が見つかりません' });
  }
});

// Serve HTML pages
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.get('/book/:id', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'book.html'));
});

app.get('/cart', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'cart.html'));
});

app.get('/checkout', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'checkout.html'));
});

app.listen(PORT, () => {
  console.log(`書籍ショップサーバーがポート ${PORT} で起動しました`);
});
