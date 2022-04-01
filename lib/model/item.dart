class Item{
  final int? id;
  final String name;
  final int categoryId;

  Item(
      { this.id,
        required this.name,
        required this.categoryId});

  Item.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        categoryId=res["categoryId"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name,'categoryId':categoryId};
  }
}