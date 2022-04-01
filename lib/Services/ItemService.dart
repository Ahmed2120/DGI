import 'package:dgi/db/ItemRepository.dart';
import 'package:dgi/model/item.dart';

class ItemService{
  final _itemRepositoryRepository = ItemRepository();
  Future<int> insert(Item item) async {
    return _itemRepositoryRepository.insert(item);
  }
  Future<List<Item>> retrieve() async {
    return _itemRepositoryRepository.retrieve();
  }
  Future<int> insertCategories(List<Item> items) async {
    return _itemRepositoryRepository.batch(items);
  }
  Future<void> delete(int id) async {
    return _itemRepositoryRepository.delete(id);
  }
}