class CaptureDetailsRequest {
  final int? id;
  final int quantity;
  final String description;
  final String image;
  final int assetLocationId;
  final int itemId;
  final int transactionId;
  final int? floorId;
  final int? departmentId;
  final int? sectionId;
  final int? brandId;
  final String? serialNumber;
  final double height;
  final double width;
  final double length;
  final String color;

  CaptureDetailsRequest(
      {this.id,
      required this.image,
      required this.assetLocationId,
      required this.description,
      required this.quantity,
      required this.itemId,
      required this.transactionId,
      required this.departmentId,
      required this.floorId,
      required this.sectionId,
      required this.brandId,
      required this.serialNumber,
      required this.length,
      required this.height,
      required this.color,
      required this.width});

  CaptureDetailsRequest.fromJson(Map<String, dynamic> res)
      : id = res["Id"],
        quantity = res['Quantity'],
        description = res['Description'],
        image = res['ItemImage'],
        assetLocationId = res['AssetLocationId'],
        itemId = res['ItemId'],
        floorId = res['FloorId'],
        departmentId = res['DepartmentId'],
        sectionId = res['SectionId'],
        brandId = res['BrandId'],
        transactionId = res['TransactionId'],
        serialNumber = res['SerialNumber'],
        color = res['Color'],
        width = res["Width"],
        height = res["Height"],
        length = res["Length"];

  Map<String, Object?> toJson() {
    return {
      'Id': id,
      'AssetLocationId': assetLocationId,
      'ItemId': itemId,
      'SectionId': sectionId,
      'BrandId': brandId,
      'Description': description,
      'Quantity': quantity,
      'TransactionId': transactionId,
      'FloorId': floorId,
      'DepartmentId': departmentId,
      'SerialNumber': serialNumber,
      'Color': color,
      'Width': width,
      'Height': height,
      'Length': length,
      'ItemImage': image,
    };
  }
}
