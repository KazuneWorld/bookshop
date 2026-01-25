// Load and display books on the home page
async function loadBooks() {
    try {
        const response = await fetch('/api/books');
        const books = await response.json();
        
        const booksGrid = document.getElementById('books-grid');
        booksGrid.innerHTML = '';
        
        books.forEach(book => {
            const bookCard = createBookCard(book);
            booksGrid.appendChild(bookCard);
        });
    } catch (error) {
        console.error('書籍の読み込みに失敗しました:', error);
    }
}

function createBookCard(book) {
    const card = document.createElement('div');
    card.className = 'book-card';
    card.onclick = () => window.location.href = `/book/${book.id}`;
    
    card.innerHTML = `
        <div class="book-card-image">📖</div>
        <div class="book-card-content">
            <h3>${book.title}</h3>
            <p class="author">著者: ${book.author}</p>
            <p class="description">${book.description}</p>
            <p class="price">¥${book.price.toLocaleString()}</p>
            <button class="btn btn-success btn-block" onclick="event.stopPropagation(); addToCart(${book.id})">
                カートに追加
            </button>
        </div>
    `;
    
    return card;
}

async function addToCart(bookId) {
    try {
        const response = await fetch(`/api/books/${bookId}`);
        const book = await response.json();
        
        cart.addItem(book);
        alert(`「${book.title}」をカートに追加しました`);
    } catch (error) {
        console.error('カートへの追加に失敗しました:', error);
        alert('カートへの追加に失敗しました');
    }
}

// Load books when page loads
document.addEventListener('DOMContentLoaded', loadBooks);
