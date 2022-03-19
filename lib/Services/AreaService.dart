import 'package:dgi/model/area.dart';

import '../db/AreaRepository.dart';

class CategoryService{
  AreaRepository areaRepository = AreaRepository();
  Future<int> insert(Area area) async {
    return areaRepository.insert(area);
  }
  Future<List<Area>> retrieve() async {
    return areaRepository.retrieve();
  }
  Future<int> insertCategories(List<Area> areas) async {
    return areaRepository.batch(areas);
  }
  Future<void> delete(int id) async {
    return areaRepository.delete(id);
  }
}