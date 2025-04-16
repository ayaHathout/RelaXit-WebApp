const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
let currentProductId = null;
const setZeroProductModal = new bootstrap.Modal(document.getElementById('setZeroProductModal'));
const viewProductModal = new bootstrap.Modal(document.getElementById('viewProductModal'));

document.addEventListener('DOMContentLoaded', function () {

    document.getElementById('addProductBtn').addEventListener('click', function() {
        resetProductForm();
        document.getElementById('productForm').style.display = 'block';
        window.scrollTo(0, 0);
    });

    document.getElementById('cancelProductBtn').addEventListener('click', function() {
        document.getElementById('productForm').style.display = 'none';
    });

    document.getElementById('saveProductForm').addEventListener('submit', function(e) {
        e.preventDefault();
        saveProduct();
    });

    document.querySelectorAll('.edit-btn').forEach(button => {
        button.addEventListener('click', function() {
            const productId = this.getAttribute('data-id');
            editProduct(productId);
        });
    });

    document.querySelectorAll('.set-zero-btn').forEach(button => {
        button.addEventListener('click', function() {
            const productId = this.getAttribute('data-id');
            const productName = this.getAttribute('data-name');
            document.getElementById('setZeroProductName').textContent = productName;
            currentProductId = productId;
            setZeroProductModal.show();
        });
    });

    document.getElementById('confirmSetZeroBtn').addEventListener('click', function() {
        setProductQuantityToZero(currentProductId);
        setZeroProductModal.hide();
    });

    document.querySelectorAll('.view-btn').forEach(button => {
        button.addEventListener('click', function() {
            const productId = this.getAttribute('data-id');
            viewProduct(productId);
        });
    });

    document.getElementById('searchForm').addEventListener('submit', function(e) {
        e.preventDefault();
        loadProducts(1);
    });

    document.getElementById('categoryFilter').addEventListener('change', function() {
        loadProducts(1);
    });

    document.getElementById('pageSize').addEventListener('change', function () {
        console.log('Page size changed to:', this.value);
        loadProducts(1);
    });

    setupRealTimeSearch();
});

function setupPaginationListeners() {
    document.querySelectorAll('.pagination .page-link').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const page = this.getAttribute('data-page');
            console.log('Pagination clicked, page:', page);
            if (page && !this.parentElement.classList.contains('disabled')) {
                loadProducts(page);
            }
        });
    });
}

function resetProductForm() {
    document.getElementById('saveProductForm').reset();
    document.getElementById('productId').value = '';
    document.getElementById('currentImageContainer').style.display = 'none';
    currentProductId = null;
}

function saveProduct() {
    const form = document.getElementById('saveProductForm');
    const formData = new FormData(form);
    const url = currentProductId ? contextPath + '/admin/products/update' : contextPath + '/admin/products/add';

    fetch(url, {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok: ' + response.status);
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            document.getElementById('productForm').style.display = 'none';
            loadProducts(1);
            showAlert(data.message, 'success');
        } else {
            showAlert(data.message, 'danger');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showAlert('Failed to save product: ' + error.message, 'danger');
    });
}

function editProduct(productId) {
    fetch(contextPath + '/admin/products/' + productId)
    .then(response => {
        if (!response.ok) {
            if (response.status === 404) {
                throw new Error('Product not found');
            }
            throw new Error('Network response was not ok: ' + response.status);
        }
        return response.json();
    })
    .then(product => {
        currentProductId = product.productId;
        document.getElementById('productId').value = product.productId;
        document.getElementById('name').value = product.name;
        document.getElementById('description').value = product.description || '';
        document.getElementById('price').value = product.price;
        document.getElementById('quantity').value = product.quantity;

        if (product.category && product.category.categoryId) {
            document.getElementById('category').value = product.category.categoryId;
        } else {
            document.getElementById('category').value = '';
        }
        if (product.productImage && product.productImage !== '') {
            document.getElementById('currentImage').src = contextPath + '/images' + product.productImage;
            document.getElementById('currentImageContainer').style.display = 'block';
        } else {
            document.getElementById('currentImageContainer').style.display = 'none';
        }
        document.getElementById('productForm').style.display = 'block';
        window.scrollTo(0, 0);
    })
    .catch(error => {
        console.error('Error:', error);
        showAlert('Failed to load product for editing: ' + error.message, 'danger');
    });
}

function setProductQuantityToZero(productId) {
    fetch(contextPath + '/admin/products/delete/' + productId, {
        method: 'POST'
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok: ' + response.status);
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            loadProducts(document.querySelector('.pagination .page-item.active .page-link')?.getAttribute('data-page') || 1);
            showAlert(data.message, 'success');
        } else {
            showAlert(data.message, 'danger');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showAlert('Failed to set product quantity to zero: ' + error.message, 'danger');
    });
}

function viewProduct(productId) {
    fetch(contextPath + '/admin/products/' + productId)
    .then(response => {
        if (!response.ok) {
            if (response.status === 404) {
                throw new Error('Product not found');
            }
            throw new Error('Network response was not ok: ' + response.status);
        }
        return response.json();
    })
    .then(product => {
        console.log('View product data:', product);
        document.getElementById('viewProductName').textContent = product.name;
        document.getElementById('viewProductCategory').textContent = product.category && product.category.name ? product.category.name : 'No Category';
        document.getElementById('viewProductPrice').textContent = new Intl.NumberFormat('en-US', {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        }).format(product.price);
        document.getElementById('viewProductQuantity').textContent = product.quantity;
        document.getElementById('viewProductDescription').textContent = product.description || 'No description available';
        const viewProductImage = document.getElementById('viewProductImage');
        if (product.productImage && product.productImage !== '') {
            const imageUrl = contextPath + '/images' + product.productImage + '?t=' + new Date().getTime();
            viewProductImage.style.backgroundImage = `url('${imageUrl}')`;
            viewProductImage.innerHTML = '';
        } else {
            viewProductImage.style.backgroundImage = 'none';
            viewProductImage.innerHTML = '<div class="d-flex align-items-center justify-content-center h-100 bg-light text-secondary">' +
                                        '<i class="fas fa-image fa-3x"></i></div>';
        }
        viewProductModal.show();
    })
    .catch(error => {
        console.error('Error:', error);
        showAlert('Failed to load product details: ' + error.message, 'danger');
    });
}

function loadProducts(page) {
    const searchKeyword = document.getElementById('searchKeyword').value;
    const categoryId = document.getElementById('categoryFilter').value;
    const pageSize = document.getElementById('pageSize').value;

    let url = contextPath + '/admin/products/list?page=' + page + '&size=' + pageSize;

    if (searchKeyword) {
        url += '&keyword=' + encodeURIComponent(searchKeyword);
    }

    if (categoryId) {
        url += '&categoryId=' + categoryId;
    }

    console.log('Loading products with URL:', url);

    fetch(url)
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok: ' + response.status);
        }
        return response.json();
    })
    .then(data => {
        console.log('Received products data:', data);
        updateProductsTable(data.products);
        updatePagination(data.currentPage, data.totalPages, pageSize);
        setupPaginationListeners();
    })
    .catch(error => {
        console.error('Error:', error);
        showAlert('Failed to load products: ' + error.message, 'danger');
    });
}

function updateProductsTable(products) {
    const tableBody = document.getElementById('productsTableBody');
    if (!tableBody) {
        console.error('Table body not found');
        return;
    }
    tableBody.innerHTML = '';

    products.forEach(product => {
        console.log('Rendering product:', product);
        const row = document.createElement('tr');

        const idCell = document.createElement('td');
        idCell.textContent = product.productId;
        row.appendChild(idCell);

        const imageCell = document.createElement('td');
        if (product.productImage && product.productImage !== '') {
            const img = document.createElement('img');
            img.src = contextPath + '/images' + product.productImage + '?t=' + new Date().getTime();
            img.alt = product.name;
            img.className = 'product-thumbnail';
            img.onerror = function() {
                this.src = contextPath + '/images/Uploads/0e5d4160-83af-4e54-8fe2-6d091d580215.jpg';
            };
            imageCell.appendChild(img);
        } else {
            const placeholder = document.createElement('div');
            placeholder.className = 'placeholder product-thumbnail bg-secondary d-flex align-items-center justify-content-center';
            const icon = document.createElement('i');
            icon.className = 'fas fa-image text-white';
            placeholder.appendChild(icon);
            imageCell.appendChild(placeholder);
        }
        row.appendChild(imageCell);

        const nameCell = document.createElement('td');
        nameCell.textContent = product.name;
        row.appendChild(nameCell);

        const categoryCell = document.createElement('td');
        categoryCell.textContent = product.category && product.category.name ? product.category.name : 'No Category';
        row.appendChild(categoryCell);

        const priceCell = document.createElement('td');
        priceCell.textContent = '$' + new Intl.NumberFormat('en-US', {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        }).format(product.price);
        row.appendChild(priceCell);

        const quantityCell = document.createElement('td');
        quantityCell.textContent = product.quantity;
        row.appendChild(quantityCell);

        const actionsCell = document.createElement('td');

        const editBtn = document.createElement('button');
        editBtn.className = 'btn btn-sm btn-primary edit-btn me-1';
        editBtn.setAttribute('data-id', product.productId);
        editBtn.innerHTML = '<i class="fas fa-edit"></i>';
        editBtn.addEventListener('click', function() {
            editProduct(product.productId);
        });
        actionsCell.appendChild(editBtn);

        const setZeroBtn = document.createElement('button');
        setZeroBtn.className = 'btn btn-sm btn-danger set-zero-btn me-1';
        setZeroBtn.setAttribute('data-id', product.productId);
        setZeroBtn.setAttribute('data-name', product.name);
        setZeroBtn.innerHTML = '<i class="fas fa-ban"></i>';
        setZeroBtn.addEventListener('click', function() {
            document.getElementById('setZeroProductName').textContent = product.name;
            currentProductId = product.productId;
            setZeroProductModal.show();
        });
        actionsCell.appendChild(setZeroBtn);

        const viewBtn = document.createElement('button');
        viewBtn.className = 'btn btn-sm btn-info view-btn';
        viewBtn.setAttribute('data-id', product.productId);
        viewBtn.innerHTML = '<i class="fas fa-eye"></i>';
        viewBtn.addEventListener('click', function() {
            viewProduct(product.productId);
        });
        actionsCell.appendChild(viewBtn);

        row.appendChild(actionsCell);

        tableBody.appendChild(row);
    });
}

function updatePagination(currentPage, totalPages, pageSize) {
    const pagination = document.querySelector('.pagination');
    if (!pagination) {
        console.error('Pagination container not found');
        return;
    }
    pagination.innerHTML = '';

    const prevItem = document.createElement('li');
    prevItem.className = `page-item ${parseInt(currentPage) === 1 ? 'disabled' : ''}`;
    const prevLink = document.createElement('a');
    prevLink.className = 'page-link';
    prevLink.href = '#';
    prevLink.textContent = 'Previous';
    prevLink.setAttribute('data-page', parseInt(currentPage) - 1);
    prevItem.appendChild(prevLink);
    pagination.appendChild(prevItem);

    for (let i = 1; i <= totalPages; i++) {
        const pageItem = document.createElement('li');
        pageItem.className = `page-item ${i === parseInt(currentPage) ? 'active' : ''}`;
        const pageLink = document.createElement('a');
        pageLink.className = 'page-link';
        pageLink.href = '#';
        pageLink.textContent = i;
        pageLink.setAttribute('data-page', i);
        pageItem.appendChild(pageLink);
        pagination.appendChild(pageItem);
    }

    const nextItem = document.createElement('li');
    nextItem.className = `page-item ${parseInt(currentPage) === totalPages ? 'disabled' : ''}`;
    const nextLink = document.createElement('a');
    nextLink.className = 'page-link';
    nextLink.href = '#';
    nextLink.textContent = 'Next';
    nextLink.setAttribute('data-page', parseInt(currentPage) + 1);
    nextItem.appendChild(nextLink);
    pagination.appendChild(nextItem);

    const pageSizeSelect = document.getElementById('pageSize');
    if (pageSizeSelect) {
        pageSizeSelect.value = pageSize;
    }

    console.log('Pagination updated: currentPage=', currentPage, 'totalPages=', totalPages, 'pageSize=', pageSize);
}

function setupRealTimeSearch() {
    const searchInput = document.getElementById('searchKeyword');
    if (!searchInput) return;

    let debounceTimer;

    searchInput.addEventListener('input', function() {
        clearTimeout(debounceTimer);
        debounceTimer = setTimeout(() => {
            loadProducts(1);
        }, 500);
    });
}

function showAlert(message, type) {
    const alert = document.createElement('div');
    alert.className = `alert alert-${type} alert-dismissible fade show`;
    alert.role = 'alert';
    alert.innerHTML = `
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    `;

    const cardBody = document.querySelector('.card-body');
    cardBody.insertBefore(alert, cardBody.firstChild);

    setTimeout(() => {
        const bsAlert = new bootstrap.Alert(alert);
        bsAlert.close();
    }, 5000);
}