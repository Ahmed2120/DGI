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
  final String? serialNumber;
  int? isUploaded;

  CaptureDetails(
      {this.id, this.name,
      required this.image,
      required this.assetLocationId,
      required this.description,
      required this.quantity,
      required this.itemId,
      required this.departmentId,required this.floorId,
      required this.sectionId,required this.serialNumber,
      this.isUploaded=0});

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
        serialNumber = res['SerialNumber'],
        isUploaded = res["isUploaded"];

  Map<String, Object?> toMap() {
    return {'Id': id, 'Name': name,'Image':image,'AssetLocationId':assetLocationId, 'ItemId':itemId,
      'Description':description,'Quantity':quantity,'FloorId':floorId,
      'DepartmentId':departmentId,'SectionId':sectionId,'SerialNumber':serialNumber,'isUploaded':isUploaded};
  }
}
