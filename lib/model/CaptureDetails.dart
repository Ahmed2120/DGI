class CaptureDetails {
  final int? id;
  final String? name;
  final int quantity;
  final String description;
  final String image;
  final int assetLocationId;
  final int itemId;
  final int? floorId;
  final int? departmentId;
  final int? sectionId;
  final int? brandId;
  final String? serialNumber;
  int? isUploaded;
  final double height;
  final double width;
  final double length;
  final String color;

  CaptureDetails(
      {this.id,
      this.name,
      required this.image,
      required this.assetLocationId,
      required this.description,
      required this.quantity,
      required this.itemId,
      required this.departmentId,
      required this.floorId,
      required this.sectionId,
      required this.brandId,
      required this.serialNumber,
      this.isUploaded = 0,
      required this.length,
      required this.height,
      required this.color,
      required this.width});

  CaptureDetails.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"],
        quantity = res['Quantity'],
        description = res['Description'],
        image = res['Image'],
        assetLocationId = res['AssetLocationId'],
        itemId = res['ItemId'],
        floorId = res['FloorId'],
        departmentId = res['DepartmentId'],
        sectionId = res['SectionId'],
        brandId = res['BrandId'],
        serialNumber = res['SerialNumber'],
        isUploaded = res["isUploaded"],
        color = res['Color'],
        width = res["Width"].toDouble(),
        height = res["Height"].toDouble(),
        length = res["Length"].toDouble();

  Map<String, Object?> toMap() {
    return {
      'Id': id,
      'Name': name,
      'AssetLocationId': assetLocationId,
      'ItemId': itemId,
      'Description': description,
      'Quantity': quantity,
      'FloorId': floorId,
      'DepartmentId': departmentId,
      'SectionId': sectionId,
      'BrandId': brandId,
      'SerialNumber': serialNumber,
      'isUploaded': isUploaded,
      'Color': color,
      'Width': width,
      'Height': height,
      'Length': length,
      'Image': image,
    };
  }
}
