class Country{
  final int id;
  final String name;

  Country(
      { required this.id,
        required this.name});

  Country.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name};
  }
}