SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


CREATE TABLE `books` (
  `bookID` int(10) NOT NULL,
  `category` int(11) DEFAULT 0,
  `writer` varchar(255) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `price` int(10) NOT NULL,
  `stock` int(10) NOT NULL,
  `good_flg` tinyint(1) DEFAULT 0,
  `image` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `books` (`bookID`, `category`, `writer`, `company`, `title`, `price`, `stock`, `good_flg`, `image`) VALUES
(33, 1, '嶋津 輝', '東京創刊社', 'カフェーの帰り道', 1870, 10, 0, 'book_watoji.png'),
(34, 1, '上橋 菜穂子, 白浜 鴎', '講談社', '神の蝶、舞う果て', 1980, 10, 1, 'book_watoji.png'),
(35, 1, '町田 そのこ', '東京創刊社', '蛍たちの祈り', 1980, 10, 0, 'book_watoji.png'),
(36, 1, '杉江 松恋', '光文社', '日本の犯罪小説', 2420, 10, 0, 'book_watoji.png'),
(37, 1, '逸木 裕', '角川文庫', '星空の16進数', 1034, 10, 0, 'book_watoji.png'),
(38, 1, '三島 由紀夫', '新潮文庫', '青の時代', 693, 10, 0, 'book_watoji.png'),
(39, 1, '土屋うさぎ', '宝島社', '謎の香りはパン屋から', 1650, 10, 0, 'book_watoji.png'),
(40, 2, 'ペンギン', '緑書房', 'ペンギンたちの素顔カレンダー 2026（壁掛け）', 1760, 10, 0, 'calender_kabekake.png'),
(41, 2, 'シマエナガ', 'インプレス', 'カレンダー2026 まんまるかわいい雪の妖精 シマエナガちゃん', 1210, 10, 1, 'calender_kabekake.png'),
(42, 2, 'モモンガ', 'インプレス', 'カレンダー2026 森の妖精 モモンガ', 1210, 10, 0, 'calender_kabekake.png'),
(43, 2, '猫', '永岡書店', '2026 にゃん プチカレンダー', 495, 10, 0, 'calender_kabekake.png'),
(44, 2, '猫', '株式会社日本ホールマーク', 'ホールマーク 2026年 カレンダー 壁掛け 大 ほめにゃんこ', 1925, 10, 0, 'calender_kabekake.png'),
(45, 2, '犬', '株式会社日本ホールマーク', 'ホールマーク 2026年 カレンダー 壁掛け 大 ほめわんこ', 1750, 10, 0, 'calender_kabekake.png'),
(46, 3, '尾田 栄一郎', '集英社', 'ONE PIECE 1', 484, 10, 0, 'entertainment_comic.png'),
(47, 3, '赤坂アカ×横槍メンゴ', '集英社', '推しの子 1', 659, 10, 0, 'entertainment_comic.png'),
(48, 3, '古舘春一', '集英社', 'ハイキュー!! 1', 460, 10, 1, 'entertainment_comic.png'),
(49, 3, '青山 剛昌', '小学館', '名探偵コナン 1', 583, 10, 0, 'entertainment_comic.png'),
(50, 3, '山田鐘人, アベツカサ', '小学館', '葬送のフリーレン 1', 583, 10, 0, 'entertainment_comic.png'),
(51, 3, '日向夏', '主婦の友社', '薬屋のひとりごと 1', 638, 10, 0, 'entertainment_comic.png'),
(52, 4, 'せな けいこ', 'ポプラ社', 'おばけのてんぷら', 1430, 10, 0, 'book_kids_jidousyo.png'),
(53, 4, '新美 南吉', '偕成社', '手ぶくろを買いに', 1540, 10, 0, 'book_kids_jidousyo.png'),
(54, 4, 'わたなべゆういち', 'フレーベル館', 'ねこざかな', 1650, 10, 0, 'book_kids_jidousyo.png'),
(55, 4, 'やなせたかし', 'フレーベル館', 'アンパンマンと だだんだん', 1188, 10, 0, 'book_kids_jidousyo.png'),
(56, 4, '島田 ゆか', '文溪堂', 'バムとケロのそらのたび', 1575, 10, 1, 'book_kids_jidousyo.png'),
(57, 4, 'キヨノサチコ', '偕成社', 'ノンタンおやすみなさい', 660, 10, 0, 'book_kids_jidousyo.png'),
(58, 4, '林 明子', '福音館書店', 'こんとあき', 1540, 10, 0, 'book_kids_jidousyo.png'),
(59, 4, 'アン・グットマン', '河出書房新社', 'リサとガスパールのであい', 1200, 10, 0, 'book_kids_jidousyo.png'),
(60, 5, '株式会社フレアリンク', '株式会社フレアリンク', 'スッキリわかるSQL入門', 3080, 10, 0, 'book3_blue.png'),
(61, 5, '株式会社フレアリンク', '株式会社フレアリンク', 'スッキリわかるJava入門', 3080, 10, 1, 'book3_blue.png'),
(62, 5, '株式会社フレアリンク', '株式会社フレアリンク', 'スッキリわかるサーブレット＆JSP入門', 3080, 10, 0, 'book3_blue.png'),
(63, 4, '文響社', '文響社', 'うんこドリル　プログラミング', 1078, 10, 1, 'book_kids_jidousyo.png');

CREATE TABLE `orders` (
  `orderID` int(10) NOT NULL,
  `userID` int(10) NOT NULL,
  `order_date` date NOT NULL,
  `deliveryDate` date DEFAULT NULL,
  `deliveryFlg` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `order_detail` (
  `detailID` int(10) NOT NULL,
  `orderID` int(10) NOT NULL,
  `bookID` int(10) NOT NULL,
  `quantity` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `users` (
  `userID` int(10) NOT NULL,
  `admin_flg` int(1) DEFAULT 0,
  `name` varchar(10) NOT NULL,
  `address` varchar(50) DEFAULT NULL,
  `pass` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `users` (`userID`, `admin_flg`, `name`, `address`, `pass`) VALUES
(1, 1, 'admin', NULL, '1234'),
(2, 0, 'user1', 'user1@a', '1234');


ALTER TABLE `books`
  ADD PRIMARY KEY (`bookID`);

ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderID`),
  ADD KEY `userID` (`userID`);

ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`detailID`),
  ADD KEY `orderID` (`orderID`),
  ADD KEY `bookID` (`bookID`);

ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`),
  ADD UNIQUE KEY `unique_name` (`name`),
  ADD UNIQUE KEY `unique_address` (`address`);


ALTER TABLE `books`
  MODIFY `bookID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

ALTER TABLE `orders`
  MODIFY `orderID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `order_detail`
  MODIFY `detailID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `users`
  MODIFY `userID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;


ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`);

ALTER TABLE `order_detail`
  ADD CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`),
  ADD CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`bookID`) REFERENCES `books` (`bookID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
