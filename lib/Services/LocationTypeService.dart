import 'package:dgi/db/LocationTypeRepository.dart';
import 'package:dgi/model/locationType.dart';

class LocationTypeService{
  LocationTypeRepository locationTypeRepository = LocationTypeRepository();
  Future<int> insert(LocationType locationType) async {
    return locationTypeRepository.insert(locationType);
  }
  Future<List<LocationType>> retrieve() async {
    return locationTypeRepository.retrieve();
  }
  Future<int> insertCategories(List<LocationType> locationTypes) async {
    return locationTypeRepository.batch(locationTypes);
  }
  Future<void> delete(int id) async {
    return locationTypeRepository.delete(id);
  }
}