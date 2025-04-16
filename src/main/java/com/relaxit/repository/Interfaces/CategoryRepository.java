package com.relaxit.repository.Interfaces;
import com.relaxit.domain.models.Category;
import java.util.List;

public interface CategoryRepository {
    List<Category> getAllCategories();
    Category findById(Long id);
    Category save(Category category);
    void delete(Long id);
    void close();
}