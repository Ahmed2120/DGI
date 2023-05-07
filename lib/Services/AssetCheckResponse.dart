import 'package:dgi/model/asset.dart';
import 'package:dgi/model/assetCheck.dart';

class AssetCheckResponse{
  final int id;
  List<AssetCheck> assets;
  int totalRecords;
  int totalPages;
  AssetCheckResponse(
      { required this.assets,
        required this.id,
        required this.totalPages,
        required this.totalRecords});
  AssetCheckResponse.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        assets = res["Data"].map<AssetCheck>((e) => AssetCheck.fromMap(e)).toList(),
        totalPages = res["TotalPages"],
        totalRecords = res["TotalRecords"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Assets':assets,'TotalPages':totalPages,'TotalRecords':totalRecords};
  }
}