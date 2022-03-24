class LocationType{
  final int? id;
  final String name;

  LocationType(
      { this.id,
        required this.name});

  LocationType.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name};
  }
}