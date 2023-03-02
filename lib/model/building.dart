class Building{
  final int? id;
  final String name;

  Building(
      { this.id,
        required this.name});

  Building.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name};
  }
}