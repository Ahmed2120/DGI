class Country{
  final int? id;
  final String name;

  Country(
      { this.id,
        required this.name});

  Country.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name};
  }
}