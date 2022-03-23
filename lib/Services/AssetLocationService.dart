import 'package:dgi/db/AssetLocationRepository.dart';
import 'package:dgi/model/assetLocation.dart';


class AssetLocationService{
  final AssetLocationRepository _assetLocationRepository = AssetLocationRepository();
  Future<int> insert(AssetLocation assetLocation) async {
    return _assetLocationRepository.insert(assetLocation);
  }
  Future<List<AssetLocation>> retrieve() async {
    return _assetLocationRepository.retrieve();
  }
  Future<int> batch(List<AssetLocation> assetsLocations) async {
    return _assetLocationRepository.batch(assetsLocations);
  }
  Future<void> delete(int id) async {
    return _assetLocationRepository.delete(id);
  }
}