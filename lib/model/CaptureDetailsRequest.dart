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
  final String? serialNumber;

  CaptureDetailsRequest(
      {this.id,
      required this.image,
      required this.assetLocationId,
      required this.description,
      required this.quantity,
      required this.itemId,required this.transactionId,
      required this.departmentId,required this.floorId,
      required this.sectionId,required this.serialNumber});

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
        transactionId = res['TransactionId'],
        serialNumber = res['SerialNumber'];

  Map<String, Object?> toJson() {
    return {'Id': id,'ItemImage':image,'AssetLocationId':assetLocationId, 'ItemId':itemId,'SectionId':sectionId,
      'Description':description,'Quantity':quantity,'TransactionId':transactionId,'FloorId':floorId,
      'DepartmentId':departmentId,'SerialNumber':serialNumber};
  }
}
