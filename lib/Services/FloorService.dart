import 'package:dgi/db/FloorRepository.dart';
import 'package:dgi/model/floor.dart';


class FloorService{
  FloorRepository floorRepository = FloorRepository();
  Future<int> insert(Floor floor) async {
    return floorRepository.insert(floor);
  }
  Future<List<Floor>> retrieve() async {
    return floorRepository.retrieve();
  }
  Future<int> batch(List<Floor> floors) async {
    return floorRepository.batch(floors);
  }
  Future<void> delete(int id) async {
    return floorRepository.delete(id);
  }
}