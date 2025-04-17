

const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));


let globalCartData = {
    cartItemCount: 0,
    cartTotal: 0,
    grandTotal: 0,
    cartItems: []
};

document.addEventListener('DOMContentLoaded', function() {
    
    initCart();
    
    setInterval(checkForCartUpdates, 5000);
});

function initCart() {
    console.log('Initializing cart functionality...');
    
    if (!localStorage.getItem('lastCartUpdate')) {
        localStorage.setItem('lastCartUpdate', Date.now().toString());
    }
    
    document.querySelectorAll('.add-to-cart').forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const productId = this.getAttribute('data-product-id');
            let quantity = 1;
            
            const detailQuantityInput = document.getElementById('product-quantity');
            if (detailQuantityInput) {
                quantity = parseInt(detailQuantityInput.value) || 1;
            } else {
                const quantityInput = document.querySelector('#quantity-' + productId);
                if (quantityInput) {
                    quantity = parseInt(quantityInput.value) || 1;
                }
            }
            console.log('Adding to cart:', {productId, quantity});
            addToCart(productId, Math.max(1, quantity));
        });
    });


    if (document.querySelector('.shopping-cart')) {
        initCartPage();
    }
   
    initMiniCart();

    function addCheckoutButtonListeners() {
        document.querySelectorAll('#checkout-button, .cart-bottom a.btn-primary').forEach(button => {
            if (!button.classList.contains('disabled')) {
                button.addEventListener('click', handleCheckoutClick);
            }
        });
    }
    document.addEventListener('DOMContentLoaded', function() {
        initCart();
        addCheckoutButtonListeners();
        
        const originalUpdateCartDisplay = updateCartDisplay;
        updateCartDisplay = function(data) {
            originalUpdateCartDisplay(data);
            addCheckoutButtonListeners();
        };
        
        setInterval(checkForCartUpdates, 5000);
    });
    loadCartData();
}

function initCartPage() {
    console.log("Initializing cart page...");
    document.querySelectorAll('.increase-button').forEach(button => {
        button.addEventListener('click', function() {
            const cartId = this.getAttribute('data-cart-id');
            console.log("Increasing quantity for cart ID:", cartId);
            const input = this.parentElement.querySelector('.number');
            const newQuantity = parseInt(input.value || input.textContent) + 1;
            updateCartItemQuantity(cartId, newQuantity);
        });
    });

    document.querySelectorAll('.decrease-button').forEach(button => {
        button.addEventListener('click', function() {
            const cartId = this.getAttribute('data-cart-id');
            console.log("Decreasing quantity for cart ID:", cartId);
            const input = this.parentElement.querySelector('.number');
            const currentQuantity = parseInt(input.value || input.textContent);
            if (currentQuantity > 1) {
                updateCartItemQuantity(cartId, currentQuantity - 1);
            }
        });
    });

    document.querySelectorAll('.remove-product, .remove-cart-item').forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const cartId = this.getAttribute('data-cart-id');
            console.log("Prompting removal for cart ID:", cartId);
            showConfirmationDialog(
                'Remove Item',
                'Are you sure you want to remove this item from your cart?',
                () => removeCartItem(cartId)
            );
        });
    });

    const clearCartButton = document.querySelector('#clear-cart');
    if (clearCartButton) {
        clearCartButton.addEventListener('click', function(e) {
            e.preventDefault();
            console.log("Prompting to clear cart");
            showConfirmationDialog(
                'Clear Cart',
                'Are you sure you want to clear all items from your cart?',
                () => clearCart()
            );
        });
    }
}
function handleCheckoutClick(e) {
    e.preventDefault();
    fetch(contextPath + '/check-login', {
        method: 'GET',
        headers: {
            'X-Requested-With': 'XMLHttpRequest'
        }
    })
    .then(response => response.json())
    .then(data => {
        if (data.loggedIn) {
            window.location.href = contextPath + '/checkout';
        } else {
            showConfirmationDialog(
                'Login Required',
                'You need to be logged in to proceed to checkout. Would you like to log in now?',
                () => {
                    window.location.href = contextPath + '/login?redirect=' + encodeURIComponent(contextPath + '/checkout');
                }
            );
        }
    })
    .catch(error => {
        console.error('Error checking login status:', error);
        showConfirmationDialog(
            'Login Required',
            'You need to be logged in to proceed to checkout. Would you like to log in now?',
            () => {
                window.location.href = contextPath + '/login?redirect=' + encodeURIComponent(contextPath + '/checkout');
            }
        );
    });
}

function updateMiniCart(items) {
    const container = document.querySelector('.all-cart-product');
    if (!container) {
        console.warn("Mini cart container not found");
        return;
    }

    console.log("Updating mini cart with", items.length, "items");

    if (!items || items.length === 0) {
        container.innerHTML = '<p class="text-center p-3">Your cart is empty</p>';
        console.log("Mini cart set to empty");
        return;
    }

    container.innerHTML = items.map(item => `
        <div class="single-cart clearfix" data-cart-id="${item.cartId}">
            <div class="cart-photo">
                <img src="${contextPath}/images${item.product.imageUrl}?t=${Date.now()}"
                     alt="${item.product.name}" class="img-fluid">
            </div>
            <div class="cart-info">
                <a href="${contextPath}/product/${item.product.productId}">
                    ${item.product.name}
                </a>
                <p class="mb-0">Price: $${item.product.price.toFixed(2)}</p>
                <p class="mb-0">Qty: ${item.quantity}</p>
                <span class="cart-delete">
                    <a href="#" class="remove-cart-item" data-cart-id="${item.cartId}">
                        <i class="zmdi zmdi-close"></i>
                    </a>
                </span>
            </div>
        </div>
    `).join('');

    console.log("Mini cart updated");

    document.querySelectorAll('.remove-cart-item').forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            const cartId = this.getAttribute('data-cart-id');
            showConfirmationDialog(
                'Remove Item',
                'Are you sure you want to remove this item from your cart?',
                () => removeCartItem(cartId)
            );
        });
    });
}

function showConfirmationDialog(title, message, onConfirm) {
    // Remove any existing dialog
    const existing = document.querySelector('.confirmation-dialog');
    if (existing) existing.remove();

    // Create dialog container
    const dialog = document.createElement('div');
    dialog.className = 'confirmation-dialog';
    dialog.innerHTML = `
        <div class="dialog-content">
            <h3 class="dialog-title">${title}</h3>
            <p class="dialog-message">${message}</p>
            <div class="dialog-buttons">
                <button class="dialog-button cancel">Cancel</button>
                <button class="dialog-button confirm">Confirm</button>
            </div>
        </div>
    `;
    document.body.appendChild(dialog);

    // Add event listeners
    const cancelButton = dialog.querySelector('.cancel');
    const confirmButton = dialog.querySelector('.confirm');

    cancelButton.addEventListener('click', () => {
        dialog.classList.remove('show');
        setTimeout(() => dialog.remove(), 300);
    });

    confirmButton.addEventListener('click', () => {
        onConfirm();
        dialog.classList.remove('show');
        setTimeout(() => dialog.remove(), 300);
    });

    // Show dialog with animation
    setTimeout(() => dialog.classList.add('show'), 10);

    // Close on click outside
    dialog.addEventListener('click', (e) => {
        if (e.target === dialog) {
            dialog.classList.remove('show');
            setTimeout(() => dialog.remove(), 300);
        }
    });
}

// Add confirmation dialog styles
if (!document.querySelector('style[data-confirmation-dialog]')) {
    const style = document.createElement('style');
    style.setAttribute('data-confirmation-dialog', 'true');
    style.textContent = `
        .confirmation-dialog {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10001;
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        
        .confirmation-dialog.show {
            opacity: 1;
        }
        
        .dialog-content {
            background: linear-gradient(135deg, rgba(50, 50, 50, 0.95), rgba(30, 30, 30, 0.95));
            backdrop-filter: blur(8px);
            border-radius: 12px;
            padding: 24px;
            max-width: 400px;
            width: 90%;
            color: #ffffff !important;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.1);
            transform: translateY(-20px);
            transition: transform 0.3s ease;
        }
        
        .confirmation-dialog.show .dialog-content {
            transform: translateY(0);
        }
        
        .dialog-title {
            color: #ffffff !important;
            margin: 0 0 12px;
            font-size: 20px;
            font-weight: 600;
        }
        
        .dialog-message {
            margin: 0 0 20px;
            font-size: 15px;
            line-height: 1.5;
        }
        
        .dialog-buttons {
            display: flex;
            gap: 12px;
            justify-content: flex-end;
        }
        
        .dialog-button {
            padding: 8px 16px;
            border-radius: 8px;
            border: none;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.2s ease;
        }
        
        .dialog-button.cancel {
            background: rgba(100, 100, 100, 0.7);
            color: #ffffff !important;
        }
        
        .dialog-button.cancel:hover {
            background: rgba(120, 120, 120, 0.7);
        }
        
        .dialog-button.confirm {
            background: linear-gradient(135deg, #4CAF50, #2E7D32);
            color: #ffffff !important;
        }
        
        .dialog-button.confirm:hover {
            background: linear-gradient(135deg, #66BB6A, #388E3C);
        }
        
        @media (max-width: 768px) {
            .dialog-content {
                width: 95%;
                padding: 16px;
            }
            
            .dialog-title {
                font-size: 18px;
            }
            
            .dialog-message {
                font-size: 14px;
            }
        }
    `;
    document.head.appendChild(style);
}

// Existing functions (unchanged for brevity, but included for completeness)
function checkForCartUpdates() {
    const currentCartUpdate = localStorage.getItem('cartLastUpdated') || '0';
    const lastChecked = localStorage.getItem('lastCartUpdate') || '0';
    
    if (currentCartUpdate > lastChecked) {
        console.log("Cart updated in another tab, refreshing cart data");
        loadCartData();
        localStorage.setItem('lastCartUpdate', Date.now().toString());
    }
}

function loadCartData() {
    console.log("Loading cart data...");
    fetch(contextPath + '/cart/items')
    .then(response => {
        if (!response.ok) throw new Error('Network response was not ok');
        return response.json();
    })
    .then(data => {
        console.log("Cart data loaded:", data);
        if (data.success !== false) {
            
            globalCartData = data;
            
            localStorage.setItem('cartLastUpdated', Date.now().toString());
            localStorage.setItem('lastCartUpdate', Date.now().toString());
            
            updateCartDisplay(data);
            
            // update other open tabs
            broadcastCartUpdate(data);
        }
    })
    .catch(error => {
        console.error("Error loading cart data:", error);
    });
}

function broadcastCartUpdate(data) {
    
    if ('BroadcastChannel' in window) {
        const bc = new BroadcastChannel('cart_updates');
        bc.postMessage({
            type: 'cart_updated',
            data: data
        });
    }
    
    try {
        localStorage.setItem('cartData', JSON.stringify(data));
    } catch (e) {
        console.warn("Could not store cart data in localStorage:", e);
    }
}

if ('BroadcastChannel' in window) {
    const bc = new BroadcastChannel('cart_updates');
    bc.onmessage = function(event) {
        if (event.data.type === 'cart_updated') {
            console.log("Received cart update from another tab");
            updateCartDisplay(event.data.data);
        }
    };
}

function addToCart(productId, quantity) {
    console.log("Attempting to add product:", productId, "quantity:", quantity);
    
    const addButton = document.querySelector(`.add-to-cart[data-product-id="${productId}"]`);
    const originalText = addButton?.innerHTML;
    if (addButton) {
        addButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Adding...';
        addButton.disabled = true;
    }
    
    fetch(contextPath + '/cart/update', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: `action=add&productId=${productId}&quantity=${quantity}`
    })
    .then(response => {
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json();
    })
    .then(data => {
        console.log("Parsed response data:", data);
        
        const operationSuccess = data.success !== false && (data.cartItemCount !== undefined || data.cartItems !== undefined);
        
        if (operationSuccess) {

            globalCartData = data;
            
            updateCartDisplay(data);

            broadcastCartUpdate(data);
            
            localStorage.setItem('cartLastUpdated', Date.now().toString());

            const quantityInput = document.getElementById('product-quantity');
            if (quantityInput) {
                quantityInput.value = 1;
                validateQuantity();
            }
            
            showNotification('Product added to cart successfully!', 'success');
        } else {
            showNotification(data.error || 'Failed to add product to cart', 'error');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        fetch(contextPath + '/cart/items')
            .then(res => res.json())
            .then(latestData => {
                updateCartDisplay(latestData);
                const quantityInput = document.getElementById('product-quantity');
                if (quantityInput) {
                    quantityInput.value = 1;
                    validateQuantity();
                }
                showNotification('Product may have been added - refreshing cart', 'success');
            })
            .catch(e => {
                showNotification('An error occurred while adding to cart', 'error');
            });
    })
    .finally(() => {
        if (addButton) {
            addButton.innerHTML = originalText;
            addButton.disabled = false;
        }
    });
}

function initMiniCart() {
    const cartIcon = document.querySelector('.cart-icon');
    const miniCart = document.querySelector('.mini-cart-brief');
    
    if (cartIcon && miniCart) {
        cartIcon.addEventListener('click', function (e) {
            e.preventDefault();
            miniCart.classList.toggle('show');
            
            if (miniCart.classList.contains('show')) {
                loadCartData();
            }
        });
        
        document.addEventListener('click', function (e) {
            if (!miniCart.contains(e.target) && e.target !== cartIcon) {
                miniCart.classList.remove('show');
            }
        });
    }
}

function updateCartItemQuantity(cartId, quantity) {
    console.log("Updating quantity for cart ID:", cartId, "to", quantity);
    fetch(contextPath + '/cart/update', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: `action=update&cartId=${cartId}&quantity=${quantity}`
    })
    .then(response => {
        if (!response.ok) throw new Error('Network response was not ok');
        return response.json();
    })
    .then(data => {
        console.log("Update quantity response:", data);
        if (data.success) {
            globalCartData = data;
            updateCartDisplay(data);
            broadcastCartUpdate(data);
            localStorage.setItem('cartLastUpdated', Date.now().toString());
        } else {
            showNotification(data.error || 'Failed to update quantity', 'error');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showNotification('An error occurred while updating quantity', 'error');
    });
}

function removeCartItem(cartId) {
    console.log("Removing cart item:", cartId);
    fetch(contextPath + '/cart/update', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: `action=remove&cartId=${cartId}`
    })
    .then(response => {
        if (!response.ok) throw new Error('Network response was not ok');
        return response.json();
    })
    .then(data => {
        console.log("Remove item response:", data);
        if (data.success) {
            globalCartData = data;
            updateCartDisplay(data);
            broadcastCartUpdate(data);
            localStorage.setItem('cartLastUpdated', Date.now().toString());
            showNotification('Item removed from cart', 'success');
        } else {
            showNotification(data.error || 'Failed to remove item', 'error');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showNotification('An error occurred while removing item', 'error');
    });
}

function clearCart() {
    console.log("Clearing cart");
    fetch(contextPath + '/cart/update', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: 'action=clear'
    })
    .then(response => {
        if (!response.ok) throw new Error('Network response was not ok');
        return response.json();
    })
    .then(data => {
        console.log("Clear cart response:", data);
        if (data.success) {
            globalCartData = data;
            updateCartDisplay(data);
            broadcastCartUpdate(data);
            localStorage.setItem('cartLastUpdated', Date.now().toString());
            showNotification('Cart cleared successfully', 'success');
        } else {
            showNotification(data.error || 'Failed to clear cart', 'error');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showNotification('An error occurred while clearing cart', 'error');
    });
}

function updateCartDisplay(data) {
    console.log("Updating cart display with:", data);
    
    const counters = document.querySelectorAll(
        '.cart-icon span, #cart-count, .cart-items span.item-count, .cart-counter'
    );
    
    counters.forEach(el => {
        if (el) {
            el.textContent = data.cartItemCount;
            console.log("Updated counter:", el);
        }
    });

    const cartItemsText = document.querySelector('.cart-items');
    if (cartItemsText) {
        cartItemsText.innerHTML = `You have <span class="item-count">${data.cartItemCount}</span> items in your shopping bag`;
        console.log("Updated cart items text");
    }

    document.querySelectorAll('#subtotal, .cart-totals span.float-end, .cart-total').forEach(el => {
        if (el) {
            el.textContent = `$${data.cartTotal.toFixed(2)}`;
            console.log("Updated price display:", el);
        }
    });
    
    const grandTotals = document.querySelectorAll('#grand-total');
    if (grandTotals.length > 0) {
        grandTotals.forEach(el => {
            el.textContent = `$${data.grandTotal.toFixed(2)}`;
            console.log("Updated grand total:", el);
        });
    }
    
    const shippingElements = document.querySelectorAll('#shipping');
    if (shippingElements.length > 0) {
        shippingElements.forEach(el => {
            el.textContent = `$${data.cartItemCount > 0 ? '20.00' : '0.00'}`;
            console.log("Updated shipping:", el);
        });
    }

    const miniCartContainer = document.querySelector('.all-cart-product');
    if (miniCartContainer) {
        updateMiniCart(data.cartItems);
    } else {
        console.log("Mini cart container not found, skipping update");
    }

    const cartContainer = document.querySelector('#cart-items-container');
    if (cartContainer) {
        updateCartPage(data.cartItems);
    } else {
        console.log("Not on cart page, skipping cart page update");
    }

    document.querySelectorAll('.cart-bottom a.btn-primary, #checkout-button').forEach(btn => {
        if (btn) {
            if (data.cartItemCount > 0) {
                btn.classList.remove('disabled');
                console.log("Enabled checkout button");
            } else {
                btn.classList.add('disabled');
                console.log("Disabled checkout button");
            }
        }
    });

    const checkoutContainer = document.getElementById('checkout-con');
    if (checkoutContainer) {
        updateCheckSummary();
        console.log("Cart summary section updated");
    } else {
        console.log("Cart summary section not found, skipping update");
    }
}

function updateCartPage(items) {
    const container = document.querySelector('#cart-items-container');
    if (!container) {
        console.warn("Main cart container not found");
        return;
    }

    console.log("Updating main cart page with", items ? items.length : 0, "items");

    if (!items || items.length === 0) {
        container.innerHTML = `
            <div class="empty-cart-message text-center py-5">
                <i class="fas fa-shopping-cart fa-4x mb-3"></i>
                <h4>Your cart is empty</h4>
                <p class="text-muted">Looks like you haven't added any items to your cart yet.</p>
            </div>
        `;
        console.log("Cart page set to empty");
        return;
    }

    container.innerHTML = items.map(item => `
        <div class="product d-sm-flex d-block align-items-center" data-cart-id="${item.cartId}">
            <div class="product-details">
                <div class="product-image">
                    <figure class="mb-0">
                        <img src="${contextPath}/images${item.product.imageUrl}?t=${Date.now()}"
                             alt="${item.product.name}" class="img-fluid">
                    </figure>
                </div>
                <div class="product-content">
                    <span class="product-title">${item.product.name}</span>
                </div>
            </div>
            <div class="product-price"><span>$${item.product.price.toFixed(2)}</span></div>
            <div class="product-quantity d-flex">
                <div class="product-qty-details">
                    <button class="value-button decrease-button" data-cart-id="${item.cartId}">-</button>
                    <div class="number">${item.quantity}</div>
                    <button class="value-button increase-button" data-cart-id="${item.cartId}">+</button>
                </div>
            </div>
            <div class="product-line-price"><span>$${item.itemTotal.toFixed(2)}</span></div>
            <div class="product-removal">
                <button class="remove-product" data-cart-id="${item.cartId}">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        </div>
    `).join('');

    console.log("Cart page updated");

    initCartPage();
}

function updateCheckSummary() {
    const cartTotalOuter = document.getElementById('cart-summary-items');
    if (!cartTotalOuter) {
        console.warn("Cart summary container not found");
        return;
    }

    console.log("Updating cart summary with items:", globalCartData.cartItems);

    let cartSummaryHTML ='';

    if (globalCartData.cartItems && globalCartData.cartItems.length > 0) {
        globalCartData.cartItems.forEach(item => {
            cartSummaryHTML += `
                <div class="each-item">
                    <div class="product-items">
                        <span class="heading">${item.quantity} x ${item.product.name}</span>
                    </div>
                    <div class="product-prices">
                        <span class="dollar">$${item.itemTotal.toFixed(2)}</span>
                    </div>
                </div>
            `;
        });
    } else {
        cartSummaryHTML += `
            <div class="each-item">
                <div class="product-items">
                    <span class="heading">Your cart is empty</span>
                </div>
                <div class="product-prices">
                    <span class="dollar">$0.00</span>
                </div>
            </div>
        `;
    }

    cartSummaryHTML += `
        <div class="each-item">
            <div class="product-items">
                <span class="heading">Subtotal</span>
            </div>
            <div class="product-prices">
                <span class="dollar" id="subtotal">$${globalCartData.cartTotal.toFixed(2)}</span>
            </div>
        </div>
        <div class="each-item">
            <div class="product-items">
                <span class="heading">Grand Total</span>
            </div>
            <div class="product-prices">
                <span class="dollar" id="grand-total">$${globalCartData.grandTotal.toFixed(2)}</span>
            </div>
        </div>
    `;

    cartTotalOuter.innerHTML = cartSummaryHTML;
    
    console.log("Cart summary updated");
}

function validateQuantity() {
    const quantityInput = document.getElementById('product-quantity');
    if (!quantityInput) return;
    
    const minusBtn = document.querySelector('.quantity-left-minus');
    const plusBtn = document.querySelector('.quantity-right-plus');
    const warningBox = document.getElementById('stock-warning-message');
    const warningText = document.getElementById('warning-text');
    
    const availableStock = parseInt(quantityInput.getAttribute('data-available')) || 0;
    
    let quantity = parseInt(quantityInput.value) || 0;
    
    if (quantity < 1) {
        quantity = 1;
    }
    
    if (quantity > availableStock) {
        quantity = availableStock;
        warningText.textContent = `Cannot add more than ${availableStock} item${availableStock != 1 ? 's' : ''} (available stock).`;
        warningBox.style.display = 'block';
        setTimeout(() => {
            warningBox.style.display = 'none';
        }, 3000);
    } else {
        warningBox.style.display = 'none';
    }
    
    quantityInput.value = quantity;
    
    if (quantity >= availableStock) {
        plusBtn.disabled = true;
    } else {
        plusBtn.disabled = false;
    }
    
    if (quantity <= 1) {
        minusBtn.disabled = true;
    } else {
        minusBtn.disabled = false;
    }
}

function showNotification(message, type) {
    console.log(`Showing notification: ${message} (${type})`);

    const existing = document.querySelector('.cart-notification');
    if (existing) existing.remove();

    const notification = document.createElement('div');
    notification.className = `cart-notification ${type}`;
    notification.innerHTML = `
        <i class="zmdi ${type === 'success' ? 'zmdi-check-circle' : 'zmdi-alert-circle'} icon"></i>
        <span class="notification-text">${message}</span>
        <div class="notification-progress"></div>
    `;
    document.body.appendChild(notification);

    setTimeout(() => {
        notification.classList.add('show');
        const progressBar = notification.querySelector('.notification-progress');
        progressBar.style.width = '100%';
        progressBar.style.transition = `width 2.7s linear`;
    }, 10);

    setTimeout(() => {
        notification.classList.remove('show');
        setTimeout(() => notification.remove(), 300);
    }, 2700);
}

if (!document.querySelector('style[data-cart-notification]')) {
    const style = document.createElement('style');
    style.setAttribute('data-cart-notification', 'true');
    style.textContent = `
        .cart-notification {
            position: fixed;
            top: 20px;
            right: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 16px 24px;
            border-radius: 12px;
            backdrop-filter: blur(8px);
            color: #ffffff !important;
            font-weight: 500;
            font-size: 15px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
            z-index: 10000;
            opacity: 0;
            transform: translateY(-30px) scale(0.95);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            pointer-events: none;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .cart-notification.show {
            opacity: 1;
            transform: translateY(0) scale(1);
        }
        
        .cart-notification.success {
            background: linear-gradient(135deg, rgba(76, 175, 80, 0.9), rgba(46, 125, 50, 0.95));
        }
        
        .cart-notification.error {
            background: linear-gradient(135deg, rgba(244, 67, 54, 0.9), rgba(183, 28, 28, 0.95));
        }
        
        .cart-notification .icon {
            font-size: 22px;
            flex-shrink: 0;
        }
        
        .notification-text {
            flex: 1;
            line-height: 1.4;
        }
        
        .notification-progress {
            position: absolute;
            bottom: 0;
            left: 0;
            height: 3px;
            width: 0;
            background: rgba(255, 255, 255, 0.7);
            border-radius: 0 3px 3px 0;
        }
        
        @media (max-width: 768px) {
            .cart-notification {
                top: 12px;
                right: 12px;
                left: 12px;
                max-width: calc(100% - 24px);
            }
        }
    `;
    document.head.appendChild(style);
}