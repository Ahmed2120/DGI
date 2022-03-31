class Item{
  final int? id;
  final String name;

  Item(
      { this.id,
        required this.name});

  Item.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name};
  }
}