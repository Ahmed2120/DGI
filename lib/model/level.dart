class Level{
  final int? id;
  final String name;

  Level(
      { required this.id,
        required this.name});

  Level.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name,};
  }
}