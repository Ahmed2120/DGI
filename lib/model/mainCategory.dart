class MainCategory{
  final int? id;
  final String name;

  MainCategory(
      { this.id,
        required this.name});

  MainCategory.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name};
  }
}