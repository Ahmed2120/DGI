class SectionGroup{
  final int? id;
  final String name;
  final String floorName;
  final String buildingName;

  SectionGroup(
      { this.id,
        required this.name,
        required this.floorName,
        required this.buildingName,});

  SectionGroup.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"],
        floorName = res["FloorName"],
        buildingName = res["BuildingName"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name,'FloorName':floorName,'BuildingName':buildingName};
  }
}