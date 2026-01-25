// Load and display book details
async function loadBookDetail() {
    const bookId = parseInt(window.location.pathname.split('/').pop());
    
    try {
        const response = await fetch(`/api/books/${bookId}`);
        
        if (!response.ok) {
            throw new Error('書籍が見つかりません');
        }
        
        const book = await response.json();
        displayBookDetail(book);
    } catch (error) {
        console.error('書籍の読み込みに失敗しました:', error);
        document.getElementById('book-detail').innerHTML = `
            <div class="book-detail-container">
                <h2>書籍が見つかりません</h2>
                <p>申し訳ございません。お探しの書籍が見つかりませんでした。</p>
                <a href="/" class="btn btn-primary">ホームに戻る</a>
            </div>
        `;
    }
}

function displayBookDetail(book) {
    const bookDetail = document.getElementById('book-detail');
    
    bookDetail.innerHTML = `
        <div class="book-detail-container">
            <a href="/" class="btn btn-primary">← 書籍一覧に戻る</a>
            <div class="book-detail-grid">
                <div class="book-detail-image">📖</div>
                <div class="book-detail-info">
                    <h1>${book.title}</h1>
                    <p class="author">著者: ${book.author}</p>
                    <p class="price">¥${book.price.toLocaleString()}</p>
                    <p class="description">${book.description}</p>
                    <p class="stock">在庫: ${book.stock}冊</p>
                    
                    <div class="quantity-selector">
                        <label>数量:</label>
                        <button onclick="decreaseQuantity()">-</button>
                        <input type="number" id="quantity" value="1" min="1" max="${book.stock}">
                        <button onclick="increaseQuantity()">+</button>
                    </div>
                    
                    <button class="btn btn-success btn-block" onclick="addToCartWithQuantity()">
                        カートに追加
                    </button>
                </div>
            </div>
        </div>
    `;
}

function increaseQuantity() {
    const input = document.getElementById('quantity');
    const max = parseInt(input.max);
    const current = parseInt(input.value);
    
    if (current < max) {
        input.value = current + 1;
    }
}

function decreaseQuantity() {
    const input = document.getElementById('quantity');
    const current = parseInt(input.value);
    
    if (current > 1) {
        input.value = current - 1;
    }
}

async function addToCartWithQuantity() {
    const bookId = parseInt(window.location.pathname.split('/').pop());
    const quantity = parseInt(document.getElementById('quantity').value);
    
    try {
        const response = await fetch(`/api/books/${bookId}`);
        const book = await response.json();
        
        cart.addItem(book, quantity);
        alert(`「${book.title}」を${quantity}冊カートに追加しました`);
    } catch (error) {
        console.error('カートへの追加に失敗しました:', error);
        alert('カートへの追加に失敗しました');
    }
}

// Load book details when page loads
document.addEventListener('DOMContentLoaded', loadBookDetail);
