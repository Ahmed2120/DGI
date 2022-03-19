class Floor{
  final int? id;
  final String name;

  Floor(
      { this.id,
        required this.name});

  Floor.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name};
  }
}