import '../db/LevelRepository.dart';
import '../model/level.dart';

class LevelService{
  LevelRepository levelRepository = LevelRepository();
  Future<int> insert(Level level) async {
    return levelRepository.insert(level);
  }
  Future<List<Level>> retrieve() async {
    return levelRepository.retrieve();
  }
  Future<int> batch(List<Level> levels) async {
    return levelRepository.batch(levels);
  }
  Future<void> delete(int id) async {
    return levelRepository.delete(id);
  }
}