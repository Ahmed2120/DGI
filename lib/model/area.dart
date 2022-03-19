class Area{
  final int? id;
  final String name;

  Area(
      { this.id,
        required this.name});

  Area.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name};
  }
}