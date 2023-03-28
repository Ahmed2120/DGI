import 'package:dgi/model/User.dart';
import 'package:dgi/model/assetLocationResponse.dart';

import 'sectionGroup.dart';

class TransactionResponse {
  final int id;
  final User user;
  final int transactionType;
  final String transActionTypeName;
  // final AssetLocationResponse? assetLocation;
  final List<SectionGroup>? sectionGroups;

  TransactionResponse({
    required this.id,
    required this.user,
    required this.transactionType,
    required this.transActionTypeName,
    // required this.assetLocation,
    required this.sectionGroups,
  });

  TransactionResponse.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        user = User.fromMap(res["AppUser"]),
        transactionType = res["TransactionType"],
        transActionTypeName = res["TransActionTypeName"],
        // assetLocation = AssetLocationResponse.fromMap(res["AssetLocation"]),
        sectionGroups =
            res["sections"]?.map<SectionGroup>((e) => SectionGroup.fromMap(e)).toList();

  Map<String, Object?> toMap() {
    return {
      'Id': id,
      'AppUser': user.toMap(),
      'TransactionType': transactionType,
      'TransActionTypeName': transActionTypeName,
      // 'AssetLocation': assetLocation.toMap()
    };
  }
}
