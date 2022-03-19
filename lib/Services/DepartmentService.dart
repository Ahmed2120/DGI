import 'package:dgi/db/DepartmentRepository.dart';
import 'package:dgi/model/department.dart';


class DepartmentService{
  DepartmentRepository departmentRepository = DepartmentRepository();
  Future<int> insert(Department department) async {
    return departmentRepository.insert(department);
  }
  Future<List<Department>> retrieve() async {
    return departmentRepository.retrieve();
  }
  Future<int> insertCategories(List<Department> departments) async {
    return departmentRepository.batch(departments);
  }
  Future<void> delete(int id) async {
    return departmentRepository.delete(id);
  }
}