import 'package:dgi/db/MainCategoryRepository.dart';
import '../model/mainCategory.dart';

class MainCategoryService{
  MainCategoryRepository mainCategoryRepository = MainCategoryRepository();
  Future<int> insert(MainCategory mainCategory) async {
    return mainCategoryRepository.insert(mainCategory);
  }
  Future<List<MainCategory>> retrieve() async {
    return mainCategoryRepository.retrieve();
  }
  Future<int> batch(List<MainCategory> mainCategories) async {
    return mainCategoryRepository.batch(mainCategories);
  }
  Future<void> delete(int id) async {
    return mainCategoryRepository.delete(id);
  }
}