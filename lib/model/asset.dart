class Asset {
  final int id;
  final String? barcode;
  String? serialnumber;
  final String? description;
  int? transactionId;
  String image;
  String? itemImage;
  String? itemName;
  final double? height;
  final double? width;
  final double? length;
  final String? color;
  int? floorId;
  int? sectionId;
  int? brandId;
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
      this.brandId,
      this.departmentId,
      required this.image,
        this.itemImage,
        this.itemName,
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
  itemImage = res['capture']['Item']['ImageInBase64'],
  itemName= res['capture']['Item']['Name'],
        isVerified = res["IsVerified"],
        departmentId = res["DepartmentId"],
        floorId = res["FloorId"],
        sectionId = res["SectionId"],
        brandId = res["BrandId"],
        isCounted = res["isCounted"],
        color = res['Color'],
        width = res["Width"]?.toDouble(),
        height = res["Height"]?.toDouble(),
        length = res["Length"]?.toDouble(),
        isUploaded = res["isUploaded"] ?? 0;

  Asset.fromJson(Map<String, dynamic> res)
      : id = res["Id"],
        barcode = res["Barcode"],
        serialnumber = res["SerialNumber"],
        description = res["Description"],
        image = res["AssetImageInBase64"],
  itemImage = res['itemImage'],
  itemName= res['itemName'],
        isVerified = res["IsVerified"],
        departmentId = res["DepartmentId"],
        floorId = res["FloorId"],
        sectionId = res["SectionId"],
        brandId = res["BrandId"],
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
      'BrandId': brandId,
      'SerialNumber': serialnumber,
      'Description': description,
      'AssetImageInBase64': image,
      'itemImage': itemImage,
      'itemName': itemName,
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
      'BrandId': brandId,
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
