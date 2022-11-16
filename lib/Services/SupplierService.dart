
import 'package:dgi/db/SupplierRepository.dart';

import '../model/supplier.dart';

class SupplierService{
  final _supplierRepository = SupplierRepository();
  Future<int> insert(Supplier supplier) async {
    return _supplierRepository.insert(supplier);
  }
  Future<List<Supplier>> retrieve() async {
    return _supplierRepository.retrieve();
  }
  Future<int> batch(List<Supplier> suppliers) async {
    return _supplierRepository.batch(suppliers);
  }
  Future<void> delete(int id) async {
    return _supplierRepository.delete(id);
  }
}