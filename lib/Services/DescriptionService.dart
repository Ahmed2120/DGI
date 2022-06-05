
import '../db/DescriptionRepository.dart';
import '../model/description.dart';

class DescriptionService{
  final _descriptionRepository = DescriptionRepository();
  Future<int> insert(Description description) async {
    return _descriptionRepository.insert(description);
  }
  Future<List<Description>> retrieve() async {
    return _descriptionRepository.retrieve();
  }
  Future<int> batch(List<Description> descriptions) async {
    return _descriptionRepository.batch(descriptions);
  }
  Future<void> delete(int id) async {
    return _descriptionRepository.delete(id);
  }
}