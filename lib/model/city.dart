class City{
  final int? id;
  final String name;

  City(
      { this.id,
        required this.name});

  City.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name};
  }
}