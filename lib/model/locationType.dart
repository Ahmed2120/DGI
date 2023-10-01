class LocationType{
  final int? id;
  final String name;

  LocationType(
      { this.id,
        required this.name});

  LocationType.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name};
  }
}