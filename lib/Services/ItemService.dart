import 'package:dgi/db/ItemRepository.dart';
import 'package:dgi/model/item.dart';


class ItemService{
  ItemRepository itemRepository = ItemRepository();
  Future<int> insert(Item item) async {
    return itemRepository.insert(item);
  }
  Future<List<Item>> retrieve() async {
    return itemRepository.retrieve();
  }
  Future<int> insertCategories(List<Item> items) async {
    return itemRepository.batch(items);
  }
  Future<void> delete(int id) async {
    return itemRepository.delete(id);
  }
}