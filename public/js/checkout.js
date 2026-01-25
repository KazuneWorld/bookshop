// Display order summary on checkout page
function displayOrderSummary() {
    const cartItems = cart.getItems();
    const orderItemsContainer = document.getElementById('order-items');
    const orderTotalContainer = document.getElementById('order-total');
    
    if (cartItems.length === 0) {
        window.location.href = '/cart';
        return;
    }
    
    orderItemsContainer.innerHTML = '';
    
    cartItems.forEach(item => {
        const orderItem = document.createElement('div');
        orderItem.className = 'order-item';
        
        orderItem.innerHTML = `
            <h4>${item.title}</h4>
            <div class="item-details">
                <span>${item.quantity}冊</span>
                <span>¥${(item.price * item.quantity).toLocaleString()}</span>
            </div>
        `;
        
        orderItemsContainer.appendChild(orderItem);
    });
    
    const total = cart.getTotal();
    orderTotalContainer.innerHTML = `
        <div class="order-total-line">
            <span class="total-label">合計</span>
            <span class="total-amount">¥${total.toLocaleString()}</span>
        </div>
    `;
}

// Handle checkout form submission
function handleCheckout(event) {
    event.preventDefault();
    
    const formData = new FormData(event.target);
    const orderData = {
        customer: {
            name: formData.get('name'),
            email: formData.get('email'),
            phone: formData.get('phone'),
            address: formData.get('address')
        },
        payment: formData.get('payment'),
        items: cart.getItems(),
        total: cart.getTotal()
    };
    
    // In a real application, this would send the order to a server
    console.log('注文データ:', orderData);
    
    // Clear the cart
    cart.clear();
    
    // Show success message and redirect
    alert('ご注文ありがとうございます！\n注文が確定されました。\n確認メールを送信いたしました。');
    window.location.href = '/';
}

// Initialize checkout page
document.addEventListener('DOMContentLoaded', () => {
    displayOrderSummary();
    
    const checkoutForm = document.getElementById('checkout-form');
    checkoutForm.addEventListener('submit', handleCheckout);
});
