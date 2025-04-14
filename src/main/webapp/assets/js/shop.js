function updateShop() {
    if (typeof (EventSource) !== "undefined") {
        let eventSource = new EventSource("/shop");

        eventSource.onmessage = function (event) {
            const data = JSON.parse(event.data);
            const products = data.products;
            const container = document.getElementById("productsContainer");
            const paginationContainer = document.querySelector(".pagination");

            console.log("products => " + products);

            container.innerHTML = "";

            products.forEach((curProduct, index) => {
                container.innerHTML += `
                    <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6">
                        <div class="classic-box">
                            <div class="classic_image_box box${index + 1}">
                                <figure class="mb-0">
                                    <img src="/relaxit/assets/img/classic-image1.png" alt="image" class="img-fluid">
                                </figure>
                            </div>
                            <div class="classic_box_content">
                                <div class="text_wrapper position-relative">
                                    <h6>${curProduct.name}</h6>
                                </div>
                                <p class="text-size-16">${curProduct.description}</p>
                                <div class="price_wrapper position-relative">
                                    <span class="dollar">$<span class="counter">${curProduct.price}</span></span>
                                    <a href="views/cart.jsp" class="add-to-cart" data-product-id="${curProduct.productId}">
                                        <img src="/relaxit/assets/img/cart.png" alt="image" class="img-fluid">
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                `;
            });

            // 3. عرض Pagination
            if (paginationContainer) {
                paginationContainer.innerHTML = "";

                // Previous
                if (data.pageNumber > 1) {
                    paginationContainer.innerHTML += `
                        <li class="page-item next">
                            <a class="page-link" href="shop?page=${data.pageNumber - 1}">
                                <i class="fas fa-angle-left"></i>
                            </a>
                        </li>
                    `;
                }

                // Page numbers
                for (let i = 1; i <= data.totalPages; i++) {
                    paginationContainer.innerHTML += `
                        <li class="page-item ${i === data.pageNumber ? 'active' : ''}">
                            <a class="page-link" href="shop?page=${i}">${i}</a>
                        </li>
                    `;
                }

                // Next
                if (data.pageNumber < data.totalPages) {
                    paginationContainer.innerHTML += `
                        <li class="page-item next">
                            <a class="page-link" href="shop?page=${data.pageNumber + 1}">
                                <i class="fas fa-angle-right"></i>
                            </a>
                        </li>
                    `;
                }
            }
        };
    } else {
        console.log("SSE not supported in this browser.");
    }
}

// استدعاء الفنكشن أول ما الصفحة تفتح
window.addEventListener("DOMContentLoaded", updateShop);
