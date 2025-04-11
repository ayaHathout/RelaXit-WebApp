document.addEventListener('DOMContentLoaded', function() {
  
    const addToCartBtn = document.querySelector('#add-to-cart-btn');
    if (addToCartBtn) {
        addToCartBtn.addEventListener('click', function(e) {
            e.preventDefault();
            
            const productId = this.getAttribute('data-product-id');
            let quantity = 1;
            
            const quantityInput = document.querySelector('#product-quantity');
            if (quantityInput) {
                quantity = parseInt(quantityInput.value) || 1;
            }
            
            addToCart(productId, quantity);
        });
    }
    
    const incrementBtn = document.querySelector('.quantity-right-plus');
    const decrementBtn = document.querySelector('.quantity-left-minus');
    const quantityInput = document.querySelector('#product-quantity');
    
    if (incrementBtn && quantityInput) {
        incrementBtn.addEventListener('click', function(e) {
            e.preventDefault();
            let currentVal = parseInt(quantityInput.value) || 0;
            quantityInput.value = currentVal + 1;
        });
    }
    
    if (decrementBtn && quantityInput) {
        decrementBtn.addEventListener('click', function(e) {
            e.preventDefault();
            let currentVal = parseInt(quantityInput.value) || 0;
            if (currentVal > 1) {
                quantityInput.value = currentVal - 1;
            }
        });
    }
});