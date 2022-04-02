class AssetLocation{
  final int id;
  final int areaId;
  final String businessUnit;
  final int? departmentId;
  final String name;
  final String? buildingName;
  final String? buildingAddress;
  final String? buildingNo;
  final int? floorId;
  final int? sectionId;

  AssetLocation(
      { required this.id,
        required this.name,
        this.buildingAddress,
        this.buildingName,
        this.buildingNo,
        required this.businessUnit,
        required this.areaId,
        required this.departmentId,
        required this.floorId,
        required this.sectionId
      });

  AssetLocation.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"],
        businessUnit = res["BusinessUnit"],
        buildingAddress = res["BuildingAddress"],
        buildingName = res["BuildingName"],
        buildingNo = res["BuildingNo"],
        areaId = res["AreaId"],
        departmentId = res["DepartmentId"],
        floorId = res["FloorId"],
        sectionId = res["SectionId"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name,'BusinessUnit':businessUnit,'BuildingAddress':buildingAddress,'BuildingName':buildingName,
    'BuildingNo':buildingNo,'AreaId':areaId,'DepartmentId':departmentId,'FloorId':floorId,'SectionId':sectionId};
  }
}