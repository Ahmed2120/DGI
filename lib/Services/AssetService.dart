import 'package:dgi/db/AssetRepository.dart';
import 'package:dgi/model/asset.dart';


class AssetService{
  AssetRepository assetRepository = AssetRepository();
  Future<int> insert(Asset asset) async {
    return assetRepository.insert(asset);
  }
  Future<List<Asset>> retrieve() async {
    return assetRepository.retrieve();
  }
  Future<int> insertCategories(List<Asset> assets) async {
    return assetRepository.batch(assets);
  }
  Future<void> delete(int id) async {
    return assetRepository.delete(id);
  }
  Future<List<Asset>> select(String barcode) async {
    return assetRepository.select(barcode);
  }
}