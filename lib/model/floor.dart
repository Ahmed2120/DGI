class Floor{
  final int? id;
  final String name;

  Floor(
      { this.id,
        required this.name});

  Floor.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name};
  }
}