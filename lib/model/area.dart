class Area{
  final int id;
  final String name;

  Area(
      { required this.id,
        required this.name});

  Area.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name};
  }
}