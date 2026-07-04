package model;

import java.util.List;

import dao.BooksDAO;

// カート操作ロジッククラス
public class CartLogic {

    // カートに商品を追加する
    public String addToCart(List<Book> cart, int bookId, int quantity) {
        try {
            BooksDAO dao = new BooksDAO();
            Book book = dao.findById(bookId);

            if (book == null) {
                return null;
            }

            // 数量の検証
            if (quantity < 1) {
                quantity = 1; // 最低1に制限
            }

            // カート内に既に同じ商品があるかチェック
            boolean found = false;
            for (Book b : cart) {
                if (b.getBookId() == book.getBookId()) {
                    b.setQuantity(b.getQuantity() + quantity); // 選択数量を加算
                    found = true;
                    break;
                }
            }

            // カートに存在しない場合は新規追加
            if (!found) {
                book.setQuantity(quantity); // 選択数量で追加
                cart.add(book);
            }

            return "カートに追加しました";

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // カート内の商品数量を更新する
    public boolean updateCartItem(List<Book> cart, int bookId, int quantity) {
        try {
            for (Book b : cart) {
                if (b.getBookId() == bookId) {
                    if (quantity <= 0) {
                        cart.remove(b);
                    } else {
                        b.setQuantity(quantity);
                    }
                    return true;
                }
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // カート内の商品を削除する
    public boolean deleteCartItem(List<Book> cart, int bookId) {
        try {
            return cart.removeIf(b -> b.getBookId() == bookId);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
