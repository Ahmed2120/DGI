class Category{
  final int id;
  final String name;
  final int mainCategoryId;

  Category(
      { required this.id,
        required this.name,
        required this.mainCategoryId});

  Category.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"],
        mainCategoryId = res["MainCategoryId"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name,'MainCategoryId':mainCategoryId};
  }
}