class Brand{
  final int? id;
  final String name;

  Brand(
      { this.id,
        required this.name,});

  Brand.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name};
  }
}