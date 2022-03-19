import 'dart:typed_data';

class Item {
  final int? id;
  final String name;
  final int categoryId;
  final int quantity;
  final String description;
  final Uint8List image;
  final int assetLocationId;

  Item(
      {this.id,
      required this.name,
      required this.image,
      required this.categoryId,
      required this.assetLocationId,
      required this.description,
      required this.quantity});

  Item.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        categoryId = res['categoryId'],
        quantity = res['quantity'],
        description = res['description'],
        image = res['image'],
        assetLocationId = res['assetLocationId'];

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name,'image':image,'categoryId':categoryId,'assetLocationId':assetLocationId,
      'description':description,'quantity':quantity};
  }
}
