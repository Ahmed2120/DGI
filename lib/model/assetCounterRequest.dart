import 'package:dgi/model/asset.dart';

class AssetCounterRequest{
  final int id;
  List<Asset> inventories;

  AssetCounterRequest(
      { required this.inventories,
        required this.id});

  Map<String, Object?> toJson() {
    return {'transactionId':id,'Inventories':inventories};
  }
}