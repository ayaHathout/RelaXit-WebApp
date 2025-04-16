<% System.out.println("Rendering product-management.jsp"); %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Product Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <style>
        .product-thumbnail {
            width: 50px;
            height: 50px;
            object-fit: contain;
        }
        .placeholder {
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #6c757d;
            font-size: 24px;
        }
        #viewProductImage {
            width: 100%;
            height: 200px;
            background-size: contain;
            background-repeat: no-repeat;
            background-position: center;
            background-color: #f8f9fa;
        }
        .actions-column {
            min-width: 140px;
        }
        .product-form {
            display: none;
        }
        #searchForm {
            margin-bottom: 20px;
        }
        .pagination {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5>Product Management</h5>
                        <button id="addProductBtn" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Add New Product
                        </button>
                    </div>
                    <div class="card-body">
                        <!-- Add/Edit Product Form -->
                        <div id="productForm" class="product-form mb-4">
                            <form id="saveProductForm" enctype="multipart/form-data">
                                <input type="hidden" id="productId" name="productId">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="name" class="form-label">Product Name</label>
                                            <input type="text" class="form-control" id="name" name="name" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="price" class="form-label">Price</label>
                                            <div class="input-group">
                                                <span class="input-group-text">$</span>
                                                <input type="number" class="form-control" id="price" name="price" step="0.01" min="0" required>
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="quantity" class="form-label">Quantity</label>
                                            <input type="number" class="form-control" id="quantity" name="quantity" min="0" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="category" class="form-label">Category</label>
                                            <select class="form-select" id="category" name="categoryId" required>
                                                <c:forEach items="${categories}" var="category">
                                                    <option value="${category.categoryId}">${category.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="productImage" class="form-label">Product Image</label>
                                            <input type="file" class="form-control" id="productImage" name="productImage" accept="image/*">
                                            <div id="currentImageContainer" class="mt-2" style="display: none;">
                                                <img id="currentImage" src="" alt="Current product image" class="img-thumbnail" style="height: 100px; object-fit: contain;">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" id="removeImage" name="removeImage">
                                                    <label class="form-check-label" for="removeImage">Remove current image</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <label for="description" class="form-label">Description</label>
                                            <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="d-flex">
                                    <button type="submit" class="btn btn-primary me-2">Save Product</button>
                                    <button type="button" id="cancelProductBtn" class="btn btn-secondary">Cancel</button>
                                </div>
                            </form>
                        </div>

                        <!-- Search Form -->
                        <form id="searchForm" class="row g-3 mb-4">
                            <div class="col-md-6">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="searchKeyword" placeholder="Search products...">
                                    <button class="btn btn-outline-secondary" type="submit">
                                        <i class="fas fa-search"></i> Search
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <select id="categoryFilter" class="form-select">
                                    <option value="">All Categories</option>
                                    <c:forEach items="${categories}" var="category">
                                        <option value="${category.categoryId}">${category.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <select id="pageSize" class="form-select">
                                    <option value="10" selected>10 per page</option>
                                    <option value="25">25 per page</option>
                                    <option value="50">50 per page</option>
                                    <option value="100">100 per page</option>
                                </select>
                            </div>
                        </form>

                        <!-- Products Table -->
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Image</th>
                                        <th>Name</th>
                                        <th>Category</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th class="actions-column">Actions</th>
                                    </tr>
                                </thead>
                                <tbody id="productsTableBody">
                                    <c:forEach items="${products}" var="product">
                                        <tr>
                                            <td>${product.productId}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty product.productImage}">
                                                        <img src="${pageContext.request.contextPath}/images${product.productImage}"
                                                             alt="${product.name}" class="product-thumbnail">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="placeholder product-thumbnail">
                                                            <i class="fas fa-image text-white"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${product.name}</td>
                                            <td>${product.getCategory().name != null ? product.getCategory().name : 'N/A'}</td>
                                            <td>$<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></td>
                                            <td>${product.quantity}</td>
                                            <td>
                                                <button class="btn btn-sm btn-primary edit-btn" data-id="${product.productId}">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn btn-sm btn-danger set-zero-btn" data-id="${product.productId}"
                                                        data-name="${product.name}">
                                                    <i class="fas fa-ban"></i>
                                                </button>
                                                <button class="btn btn-sm btn-info view-btn" data-id="${product.productId}">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <nav>
                            <ul class="pagination justify-content-center">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="#" data-page="${currentPage - 1}">Previous</a>
                                </li>
                                <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                    <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="#" data-page="${pageNum}">${pageNum}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="#" data-page="${currentPage + 1}">Next</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Product View Modal -->
    <div class="modal fade" id="viewProductModal" tabindex="-1" aria-labelledby="viewProductModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="viewProductModalLabel">Product Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div id="viewProductImage" class="img-thumbnail mb-3"></div>
                        </div>
                        <div class="col-md-8">
                            <h3 id="viewProductName"></h3>
                            <p><strong>Category:</strong> <span id="viewProductCategory"></span></p>
                            <p><strong>Price:</strong> $<span id="viewProductPrice"></span></p>
                            <p><strong>Quantity in Stock:</strong> <span id="viewProductQuantity"></span></p>
                            <h5>Description</h5>
                            <p id="viewProductDescription"></p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Set Quantity to Zero Confirmation Modal -->
    <div class="modal fade" id="setZeroProductModal" tabindex="-1" aria-labelledby="setZeroProductModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="setZeroProductModalLabel">Confirm Set Quantity to Zero</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Are you sure you want to set the quantity to zero for the product: <strong id="setZeroProductName"></strong>?
                    <p class="text-warning mt-2">This will mark the product as out of stock but keep it in the database.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" id="confirmSetZeroBtn" class="btn btn-danger">Set to Zero</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        window.contextPath = '${pageContext.request.contextPath}';
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/adminProduct.js"></script>
</body>
</html>