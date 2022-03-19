import 'package:dgi/db/CategoryRepository.dart';
import 'package:dgi/model/category.dart';

class CategoryService{
  CategoryRepository categoryRepository = CategoryRepository();
  Future<int> insert(Category category) async {
    return categoryRepository.insert(category);
  }
  Future<List<Category>> retrieve() async {
    return categoryRepository.retrieve();
  }
  Future<int> insertCategories(List<Category> categories) async {
    return categoryRepository.insertCategories(categories);
  }
  Future<void> delete(int id) async {
    return categoryRepository.delete(id);
  }
}