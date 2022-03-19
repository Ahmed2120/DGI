import 'package:dgi/db/CityRepository.dart';
import '../model/city.dart';

class CityService{
  CityRepository cityRepository = CityRepository();
  Future<int> insert(City city) async {
    return cityRepository.insert(city);
  }
  Future<List<City>> retrieve() async {
    return cityRepository.retrieve();
  }
  Future<int> insertCategories(List<City> cities) async {
    return cityRepository.batch(cities);
  }
  Future<void> delete(int id) async {
    return cityRepository.delete(id);
  }
}