class SectionType{
  final int? id;
  final String name;
  final int floorId;

  SectionType(
      { this.id,
        required this.name,
        required this.floorId});

  SectionType.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        floorId = res["floorId"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name,'floorId':floorId};
  }
}