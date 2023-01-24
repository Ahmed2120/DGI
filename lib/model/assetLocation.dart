class AssetLocation {
  final int id;
  final int areaId;
  final String? businessUnit;
  final int? departmentId;
  final String? name;
  final String? buildingName;
  final String? buildingAddress;
  final String? buildingNo;
  final int? floorId;
  final int? sectionId;
  final int locationType;
  final String locationTypeName;
  final String? compound;
  final String? city;
  final String? governorate;
  final String? country;

  AssetLocation(
      {required this.id,
      this.name,
      this.buildingAddress,
      this.buildingName,
      this.buildingNo,
      this.businessUnit,
      required this.areaId,
      this.departmentId,
      this.floorId,
      this.sectionId,
      required this.locationTypeName,
      required this.locationType,
      required this.compound,
      required this.city,
      required this.governorate,
      required this.country,
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
        sectionId = res["SectionId"],
        locationTypeName = res["LocationTypeName"],
        compound = res["Compound"],
        city = res["City"],
        governorate = res["Governerate"],
        country = res["Country"],
        locationType = res["LocationType"];

  Map<String, Object?> toMap() {
    return {
      'Id': id,
      'Name': name,
      'BusinessUnit': businessUnit,
      'BuildingAddress': buildingAddress,
      'BuildingName': buildingName,
      'BuildingNo': buildingNo,
      'AreaId': areaId,
      'DepartmentId': departmentId,
      'FloorId': floorId,
      'SectionId': sectionId,
      'LocationTypeName': locationTypeName,
      'LocationType': locationType,
      'Compound': compound,
      'City': city,
      'Governerate': governorate,
      'Country': country,
    };
  }
}
