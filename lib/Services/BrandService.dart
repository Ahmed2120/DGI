import 'package:dgi/db/BrandRepository.dart';

import '../db/BrandRepository.dart';
import '../db/BrandRepository.dart';
import '../model/brand.dart';

class BrandService{
  BrandRepository brandRepository = BrandRepository();
  Future<int> insert(Brand brand) async {
    return brandRepository.insert(brand);
  }
  Future<List<Brand>> retrieve() async {
    return brandRepository.retrieve();
  }
  Future<int> batch(List<Brand> brands) async {
    return brandRepository.batch(brands);
  }
  Future<void> delete(int id) async {
    return brandRepository.delete(id);
  }
}