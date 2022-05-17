import 'package:dgi/model/asset.dart';

class AssetVerificationRequest{
  final int id;
  List<Asset> verifications;

  AssetVerificationRequest(
      { required this.verifications,
        required this.id});

  Map<String, Object?> toJson() {
    return {'Id':id,'Verifications':verifications};
  }
}