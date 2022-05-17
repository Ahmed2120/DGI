class Asset {
  final int id;
  final String? barcode;
  String? serialnumber;
  final String? description;
  int? transactionId;
  String image;
  final double? height;
  final double? width;
  final double? length;
  final String? color;
  int? floorId;
  int? sectionId;
  int? departmentId;
  int? isCounted;
  int? isVerified;
  int? isUploaded;

  Asset(
      {required this.id,
      this.barcode,
      this.serialnumber,
      this.description,
      this.width,
      this.height,
      this.length,
      this.color,
      this.floorId,
      this.sectionId,
      this.departmentId,
      required this.image,
      this.isUploaded = 0,
      this.isCounted = 0,
      this.isVerified = 0,
      this.transactionId});

  Asset.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        barcode = res["Barcode"],
        serialnumber = res["SerialNumber"],
        description = res["Description"],
        image = res["AssetImageInBase64"],
        isVerified = res["IsVerified"],
        departmentId = res["DepartmentId"],
        floorId = res["FloorId"],
        sectionId = res["SectionId"],
        isCounted = res["isCounted"],
        color = res['Color'],
        width = res["Width"]?.toDouble(),
        height = res["Height"]?.toDouble(),
        length = res["Length"]?.toDouble(),
        isUploaded = res["isUploaded"] ?? 0;

  Map<String, Object?> toMap() {
    return {
      'Id': id,
      'Barcode': barcode,
      'DepartmentId': departmentId,
      'FloorId': floorId,
      'SectionId': sectionId,
      'SerialNumber': serialnumber,
      'Description': description,
      'AssetImageInBase64': image,
      'IsVerified': isVerified,
      'isCounted': isCounted,
      'Color': color,
      'Width': width,
      'Height': height,
      'Length': length,
      'isUploaded': isUploaded
    };
  }

  Map<String, Object?> toJson() {
    return {
      'Id': id,
      'AssetId': id,
      'TransactionId': transactionId,
      'DepartmentId': departmentId,
      'FloorId': floorId,
      'SectionId': sectionId,
      'SerialNumber': serialnumber,
      'AssetImage': image,
      'IsVerified': isVerified,
      'Color': color,
      'Width': width,
      'Height': height,
      'Length': length,
    };
  }
}
