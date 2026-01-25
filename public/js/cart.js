// Cart management module
class Cart {
    constructor() {
        this.items = this.loadCart();
        this.updateCartCount();
    }

    loadCart() {
        const cart = localStorage.getItem('cart');
        return cart ? JSON.parse(cart) : [];
    }

    saveCart() {
        localStorage.setItem('cart', JSON.stringify(this.items));
        this.updateCartCount();
    }

    addItem(book, quantity = 1) {
        const existingItem = this.items.find(item => item.id === book.id);
        
        if (existingItem) {
            existingItem.quantity += quantity;
        } else {
            this.items.push({
                id: book.id,
                title: book.title,
                author: book.author,
                price: book.price,
                image: book.image,
                quantity: quantity
            });
        }
        
        this.saveCart();
    }

    removeItem(bookId) {
        this.items = this.items.filter(item => item.id !== bookId);
        this.saveCart();
    }

    updateQuantity(bookId, quantity) {
        const item = this.items.find(item => item.id === bookId);
        if (item) {
            item.quantity = quantity;
            if (item.quantity <= 0) {
                this.removeItem(bookId);
            } else {
                this.saveCart();
            }
        }
    }

    getItems() {
        return this.items;
    }

    getItemCount() {
        return this.items.reduce((total, item) => total + item.quantity, 0);
    }

    getTotal() {
        return this.items.reduce((total, item) => total + (item.price * item.quantity), 0);
    }

    clear() {
        this.items = [];
        this.saveCart();
    }

    updateCartCount() {
        const cartCountElements = document.querySelectorAll('#cart-count');
        const count = this.getItemCount();
        cartCountElements.forEach(el => {
            el.textContent = count;
        });
    }
}

// Create global cart instance
const cart = new Cart();
