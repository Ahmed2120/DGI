class City{
  final int? id;
  final String name;

  City(
      { this.id,
        required this.name});

  City.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name};
  }
}