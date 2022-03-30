class Category{
  final int? id;
  final String name;
  final int mainCategoryId;

  Category(
      { this.id,
        required this.name,
        required this.mainCategoryId});

  Category.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        mainCategoryId = res["mainCategoryId"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name,'mainCategoryId':mainCategoryId};
  }
}