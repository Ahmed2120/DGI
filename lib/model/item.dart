class Item{
  final int? id;
  final String name;
  final int categoryId;

  Item(
      { this.id,
        required this.name,
        required this.categoryId});

  Item.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"],
        categoryId=res["CategoryId"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name,'CategoryId':categoryId};
  }
}