package com.relaxit.domain.services;

import com.relaxit.domain.models.Category;
import com.relaxit.repository.Impl.CategoryRepositoryImpl;
import com.relaxit.repository.Interfaces.CategoryRepository;

import java.util.List;

public class CategoryService {
    private CategoryRepository categoryRepository;

    public CategoryService() {
        categoryRepository = new CategoryRepositoryImpl();
    }

    public List<Category> getAllCategories() {
        return categoryRepository.getAllCategories();
    }

    public Category findById(Long id) {
        return categoryRepository.findById(id);
    }

    public Category saveCategory(Category category) {
        return categoryRepository.save(category);
    }

    public void deleteCategory(Long id) {
        categoryRepository.delete(id);
    }
}