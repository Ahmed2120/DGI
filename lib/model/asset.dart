class Asset {
  final int id;
  final String? barcode;
  final String? serialnumber;
  final String? description;
  final String image;
  final double? height;
  final double? width;
  final double? length;
  final String? color;
  final int? floorId;
  final int? sectionId;
  final int? departmentId;
  int? isCounted;
  int? isVerified;

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
      this.isCounted = 0,
      this.isVerified = 0});

  Asset.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        barcode = res["Barcode"],
        serialnumber = res["Serialnumber"],
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
        length = res["Length"]?.toDouble();

  Map<String, Object?> toMap() {
    return {
      'Id': id,
      'Barcode': barcode,
      'DepartmentId': departmentId,
      'FloorId': floorId,
      'SectionId': sectionId,
      'Serialnumber': serialnumber,
      'Description': description,
      'AssetImageInBase64': image,
      'IsVerified': isVerified,
      'isCounted': isCounted,
      'Color': color,
      'Width': width,
      'Height': height,
      'Length': length,
    };
  }
}
