import 'package:dgi/db/SectionTypeRepository.dart';
import 'package:dgi/model/sectionType.dart';

import '../db/sectionGroupRepository.dart';
import '../model/sectionGroup.dart';

class SectionGroupService{
  SectionGroupRepository sectionGroupRepository = SectionGroupRepository();
  Future<int> insert(SectionGroup sectionGroup) async {
    return sectionGroupRepository.insert(sectionGroup);
  }
  Future<List<SectionGroup>> retrieve() async {
    return sectionGroupRepository.retrieve();
  }
  Future<int> batch(List<SectionGroup> sectionGroups) async {
    return sectionGroupRepository.batch(sectionGroups);
  }
  Future<void> delete(int id) async {
    return sectionGroupRepository.delete(id);
  }
}