package com.relaxit.repository.interfaces;

import com.relaxit.domain.models.Product;

public interface ProductRepository {
    Product findById(Long id);
}
