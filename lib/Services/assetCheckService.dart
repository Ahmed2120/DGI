import 'package:dgi/db/SectionTypeRepository.dart';
import 'package:dgi/model/sectionType.dart';

import '../db/assetCheckRepository.dart';
import '../db/sectionGroupRepository.dart';
import '../model/assetCheck.dart';
import '../model/sectionGroup.dart';

class AssetCheckService{
  AssetCheckRepository assetCheckRepository = AssetCheckRepository();
  Future<int> insert(AssetCheck assetCheck) async {
    return assetCheckRepository.insert(assetCheck);
  }
  Future<List<AssetCheck>> retrieve() async {
    return assetCheckRepository.retrieve();
  }

  Future<AssetCheck> retrieveByBarcode(String barcode) async {
    return assetCheckRepository.retrieveByBarcode(barcode);
  }

  Future<List<AssetCheck>> retrieveChecked() async {
    return assetCheckRepository.retrieveChecked();
  }

  Future<int> batch(List<AssetCheck> assetsCheck) async {
    return assetCheckRepository.batch(assetsCheck);
  }
  Future<void> update(AssetCheck assetCheck) async {
    return assetCheckRepository.update(assetCheck);
  }
  Future<void> delete(int id) async {
    return assetCheckRepository.delete(id);
  }
}