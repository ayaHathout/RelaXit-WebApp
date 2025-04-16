function updateShop() {
    if (typeof (EventSource) !== "undefined") {
        let eventSource = new EventSource("/relaxit/shop");

        eventSource.onmessage = function (event) {
            const data = JSON.parse(event.data);
            const products = data.products;
            const container = document.getElementById("productsContainer");
            const paginationContainer = document.getElementById("pagination");

            console.log("products => " + products);
            console.log("paginationContainer --> " + paginationContainer);

            container.innerHTML = "";

            products.forEach((curProduct, index) => {
                container.innerHTML += `
                    <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6">
                        <div class="classic-box product-card">
                            <a href="/product/${curProduct.productId}" class="product-link">
                                <div class="classic_image_box box${index + 1}">
                                    <figure class="mb-0">
                                        <img src="${curProduct.productImage != null && !curProduct.productImage.isEmpty() ? pageContext.request.contextPath.concat('/images').concat(curProduct.productImage).concat('?t=').concat(currentTimeMillis) : '/relaxit/assets/images/pic.png'}" alt="${curProduct.name}" class="img-fluid">
                                    </figure>
                                </div>

                                <div class="classic_box_content">
                                    <div class="text_wrapper position-relative">
                                        <h6>${curProduct.name}</h6>
                                    </div>
                                    <p class="text-size-16">${curProduct.description}</p>
                                </div>
                            </a>

                            <div class="classic_box_content">
                                <div class="price_wrapper position-relative">
                                    <span class="dollar">$<span class="counter">${curProduct.price}</span></span>
                                    <button class="add-to-cart" data-product-id="${curProduct.productId}">
                                        <i class="zmdi zmdi-shopping-cart" style="color: white; font-size: 24px;"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                `;
            });

            console.log("data.pageNumber --> " + data.pageNumber);
            console.log("data.totalPages --> " + data.totalPages);
           // if (paginationContainer) {
         /*       console.log("In paginationnnnnnnnnnnnnnnnnnnnnnnnnnnn");
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
                }*/
           // }
        };
    }
    else  console.log("SSE not supported in this browser");
}

window.addEventListener("DOMContentLoaded", updateShop);