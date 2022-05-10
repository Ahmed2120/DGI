import 'package:dgi/model/asset.dart';

class AssetVerificationRequest{
  final int id;
  List<Asset> assets;
  int totalRecords;
  int totalPages;
  AssetVerificationRequest(
      { required this.assets,
        required this.id,
        required this.totalPages,
        required this.totalRecords});
  AssetVerificationRequest.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        assets = res["Assets"].map<Asset>((e) => Asset.fromMap(e)).toList(),
        totalPages = res["TotalPages"],
        totalRecords = res["TotalRecords"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Assets':assets,'TotalPages':totalPages,'TotalRecords':totalRecords};
  }
}