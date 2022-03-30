class MainCategory{
  final int? id;
  final String name;

  MainCategory(
      { this.id,
        required this.name});

  MainCategory.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name};
  }
}