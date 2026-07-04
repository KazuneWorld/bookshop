package model;

import dao.BooksDAO;

// 管理者用書籍操作ロジッククラス
public class AdminBookLogic {

    // 新しい本を追加する
    public boolean addBook(String title, String writer, String company, String price, String stock,
            String imageFileName, String category, String good) {
        try {
            int priceInt = Integer.parseInt(price);
            int stockInt = Integer.parseInt(stock);
            int categoryInt = Integer.parseInt(category);
            int good_flg = (good != null) ? 1 : 0;
            String bookImage = (imageFileName != null) ? imageFileName : "";
            // Bookオブジェクトを作成してDAOへ渡す
            Book newBook = new Book(0, title, writer, company, priceInt, stockInt, bookImage, categoryInt, good_flg);
            BooksDAO booksDao = new BooksDAO();
            booksDao.insertBook(newBook);
            return true;
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 本の情報を更新する
    public Book updateBook(String bookId, String title, String writer, String company, String price, String stock,
            String imageFileName, String category, String good) {
        try {
            int bookIdInt = Integer.parseInt(bookId);
            int priceInt = Integer.parseInt(price);
            int stockInt = Integer.parseInt(stock);
            int categoryInt = (category != null && !category.isEmpty()) ? Integer.parseInt(category) : 0;
            int good_flgInt = (good != null) ? 1 : 0;

            // 既存の画像を取得
            BooksDAO booksDao = new BooksDAO();
            Book existingBook = booksDao.findById(bookIdInt);
            String existingImageName = (existingBook != null) ? existingBook.getImage() : "";

            // 新しい画像がアップロードされなかった場合は、既存の画像を保持
            ImageUploadLogic imageLogic = new ImageUploadLogic();
            String bookImage = imageLogic.resolveImageName(imageFileName, existingImageName);

            Book book = new Book(bookIdInt, title, writer, company, priceInt, stockInt, bookImage, categoryInt,
                    good_flgInt);
            return booksDao.updateBook(book, bookIdInt);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return null;
        }
    }

    // 本の削除
    public boolean deleteBook(String bookId) {
        try {
            int bookIdInt = Integer.parseInt(bookId);
            BooksDAO dao = new BooksDAO();
            dao.deleteBook(bookIdInt);
            return true;
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return false;
        }
    }
}
