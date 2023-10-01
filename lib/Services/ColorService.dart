import '../db/ColorRepository.dart';
import '../model/itemColor.dart';

class ColorService{
  ColorRepository colorRepository = ColorRepository();
  Future<int> insert(ItemColor color) async {
    return colorRepository.insert(color);
  }
  Future<List<ItemColor>> retrieve() async {
    return colorRepository.retrieve();
  }
  Future<int> batch(List<ItemColor> colors) async {
    return colorRepository.batch(colors);
  }
  Future<void> delete(int id) async {
    return colorRepository.delete(id);
  }
}