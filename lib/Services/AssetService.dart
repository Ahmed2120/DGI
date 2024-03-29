import 'package:dgi/Utility/configration.dart';
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
  Future<int> batch(List<Asset> assets) async {
    return assetRepository.batch(assets);
  }
  Future<void> delete(int id) async {
    return assetRepository.delete(id);
  }
  Future<List<Asset>> select(String barcode) async {
    return assetRepository.select(barcode);
  }
  Future<List<Asset>> getAllVerifiedItems() async {
    return assetRepository.getAllVerifiedItems();
  }
  Future<List<Asset>> getAllCountedItems() async {
    return assetRepository.getAllCountedItems();
  }
  Future<int> update(Asset asset) async {
    return assetRepository.update(asset);
  }
  Future<List<Asset>> retrieveTopElement() async {
    return assetRepository.retrieveTopElement(MyConfig.PAGE_SIZE);
  }
  upload(List<Asset> items)async{
    return assetRepository.upload(items);
  }
}