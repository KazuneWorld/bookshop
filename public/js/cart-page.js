// Display cart items
function displayCart() {
    const cartItems = cart.getItems();
    const cartItemsContainer = document.getElementById('cart-items');
    const cartSummaryContainer = document.getElementById('cart-summary');
    
    if (cartItems.length === 0) {
        cartItemsContainer.innerHTML = `
            <div class="empty-cart">
                <p>カートは空です</p>
                <a href="/" class="btn btn-primary">書籍を探す</a>
            </div>
        `;
        cartSummaryContainer.innerHTML = '';
        return;
    }
    
    cartItemsContainer.innerHTML = '';
    
    cartItems.forEach(item => {
        const cartItem = document.createElement('div');
        cartItem.className = 'cart-item';
        
        cartItem.innerHTML = `
            <div class="cart-item-image">📖</div>
            <div class="cart-item-info">
                <h3>${item.title}</h3>
                <p class="author">著者: ${item.author}</p>
                <p class="price">¥${item.price.toLocaleString()} × ${item.quantity}冊</p>
            </div>
            <div class="cart-item-actions">
                <div class="quantity-selector">
                    <button onclick="updateItemQuantity(${item.id}, ${item.quantity - 1})">-</button>
                    <input type="number" value="${item.quantity}" min="1" 
                           onchange="updateItemQuantity(${item.id}, this.value)">
                    <button onclick="updateItemQuantity(${item.id}, ${item.quantity + 1})">+</button>
                </div>
                <button class="btn btn-danger" onclick="removeItem(${item.id})">削除</button>
            </div>
        `;
        
        cartItemsContainer.appendChild(cartItem);
    });
    
    const total = cart.getTotal();
    cartSummaryContainer.innerHTML = `
        <div class="cart-summary">
            <h3>合計</h3>
            <p class="total">¥${total.toLocaleString()}</p>
            <a href="/checkout" class="btn btn-success btn-block">レジに進む</a>
            <button class="btn btn-danger btn-block" onclick="clearCart()" style="margin-top: 1rem;">
                カートを空にする
            </button>
        </div>
    `;
}

function updateItemQuantity(bookId, quantity) {
    const qty = parseInt(quantity);
    if (qty > 0) {
        cart.updateQuantity(bookId, qty);
        displayCart();
    }
}

function removeItem(bookId) {
    if (confirm('この商品をカートから削除しますか？')) {
        cart.removeItem(bookId);
        displayCart();
    }
}

function clearCart() {
    if (confirm('カートを空にしてもよろしいですか？')) {
        cart.clear();
        displayCart();
    }
}

// Display cart when page loads
document.addEventListener('DOMContentLoaded', displayCart);
