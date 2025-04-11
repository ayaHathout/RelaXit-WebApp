

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
            const quantityInput = document.querySelector('#quantity-' + productId);
            const quantity = quantityInput ? parseInt(quantityInput.value) || 1 : 1;
            
            console.log('Adding to cart:', {productId, quantity});
            addToCart(productId, Math.max(1, quantity));
        });
    });


    if (document.querySelector('.shopping-cart')) {
        initCartPage();
    }

   
    initMiniCart();
    
    loadCartData();
}

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
        
        const operationSuccess = data.success !== false && 
                               (data.cartItemCount !== undefined || 
                                data.cartItems !== undefined);
        
        if (operationSuccess) {

            globalCartData = data;
            
            updateCartDisplay(data);

            broadcastCartUpdate(data);
            
            localStorage.setItem('cartLastUpdated', Date.now().toString());
            
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
            console.log("Removing item with cart ID:", cartId);
            if (confirm('Are you sure you want to remove this item?')) {
                removeCartItem(cartId);
            }
        });
    });

    const clearCartButton = document.querySelector('#clear-cart');
    if (clearCartButton) {
        clearCartButton.addEventListener('click', function(e) {
            e.preventDefault();
            console.log("Clearing cart");
            if (confirm('Are you sure you want to clear your cart?')) {
                clearCart();
            }
        });
    }
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

    // 2. Update all price displays
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

    // 3. Update mini-cart items
    const miniCartContainer = document.querySelector('.all-cart-product');
    if (miniCartContainer) {
        updateMiniCart(data.cartItems);
    } else {
        console.log("Mini cart container not found, skipping update");
    }

    // 4. Update main cart items
    const cartContainer = document.querySelector('#cart-items-container');
    if (cartContainer) {
        updateCartPage(data.cartItems);
    } else {
        console.log("Not on cart page, skipping cart page update");
    }

    // 5. Update checkout button state
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

     // 6. Update cart summary section
     const checkoutContainer = document.getElementById('checkout-con');
     if (checkoutContainer) {
         updateCheckSummary();
         console.log("Cart summary section updated");
     } else {
         console.log("Cart summary section not found, skipping update");
     }
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
                <a href="#"><img src="${item.product.imageUrl || contextPath + '/assets/images/pic.jpg'}" alt="${item.product.name}" /></a>
            </div>
            <div class="cart-info">
                <h5><a href="#">${item.product.name}</a></h5>
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
            if (confirm('Remove this item?')) {
                removeCartItem(this.getAttribute('data-cart-id'));
            }
        });
    });
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
                        <img src="${item.product.imageUrl || contextPath + '/assets/images/products/placeholder.jpg'}" alt="${item.product.name}" class="img-fluid">
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

    cartSummaryHTML += '</div>';

    cartTotalOuter.innerHTML = cartSummaryHTML;
    
    console.log("Cart summary updated");
}


function showNotification(message, type) {
    console.log(`Showing notification: ${message} (${type})`);

    const existing = document.querySelector('.cart-notification');
    if (existing) existing.remove();

    const notification = document.createElement('div');
    notification.className = `cart-notification ${type}`;
    notification.textContent = message;
    document.body.appendChild(notification);

    setTimeout(() => notification.classList.add('show'), 10);
    setTimeout(() => notification.remove(), 3000);
}

if (!document.querySelector('style[data-cart-notification]')) {
    const style = document.createElement('style');
    style.setAttribute('data-cart-notification', 'true');
    style.textContent = `
        .cart-notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 12px 24px;
            border-radius: 4px;
            color: white;
            font-weight: bold;
            z-index: 1000;
            opacity: 0;
            transform: translateY(-20px);
            transition: all 0.3s ease;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .cart-notification.show {
            opacity: 1;
            transform: translateY(0);
        }
        .cart-notification.success {
            background-color: #28a745;
        }
        .cart-notification.error {
            background-color: #dc3545;
        }
    `;
    document.head.appendChild(style);
}