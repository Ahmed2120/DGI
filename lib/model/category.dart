class Category{
  final int? id;
  final String name;

  Category(
      { this.id,
        required this.name});

  Category.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name};
  }
}