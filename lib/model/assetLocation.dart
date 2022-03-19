class AssetLocation{
  final int? id;
  final int? areaId;
  final String businessUnit;
  final int departmentId;
  final String name;
  final String buildingName;
  final String buildingAddress;
  final String buildingNo;
  final int floorId;

  AssetLocation(
      { this.id,
        required this.name,
        required this.buildingAddress,
        required this.buildingName,
        required this.buildingNo,
        required this.businessUnit,
        required this.areaId,
        required this.departmentId,
        required this.floorId
      });

  AssetLocation.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        businessUnit = res["businessUnit"],
        buildingAddress = res["buildingAddress"],
        buildingName = res["buildingName"],
        buildingNo = res["buildingNo"],
        areaId = res["areaId"],
        departmentId = res["departmentId"],
        floorId = res["floorId"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name,'businessUnit':businessUnit,'buildingAddress':buildingAddress,'buildingName':buildingName,
    'buildingNo':buildingNo,'areaId':areaId,'departmentId':departmentId,'floorId':floorId};
  }
}