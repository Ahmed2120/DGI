import 'package:dgi/db/SectionTypeRepository.dart';
import 'package:dgi/model/sectionType.dart';

class SectionTypeService{
  SectionTypeRepository sectionTypeRepository = SectionTypeRepository();
  Future<int> insert(SectionType sectionType) async {
    return sectionTypeRepository.insert(sectionType);
  }
  Future<List<SectionType>> retrieve() async {
    return sectionTypeRepository.retrieve();
  }
  Future<int> insertCategories(List<SectionType> sectionTypes) async {
    return sectionTypeRepository.batch(sectionTypes);
  }
  Future<void> delete(int id) async {
    return sectionTypeRepository.delete(id);
  }
}