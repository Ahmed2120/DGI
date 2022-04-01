class SectionType{
  final int? id;
  final String name;
  final int floorId;

  SectionType(
      { this.id,
        required this.name,
        required this.floorId});

  SectionType.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"],
        floorId = res["FloorId"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name,'FloorId':floorId};
  }
}