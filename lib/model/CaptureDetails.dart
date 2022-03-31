class CaptureDetails {
  final int? id;
  final String? name;
  final int? categoryId;
  final int quantity;
  final String description;
  final String image;
  final int assetLocationId;

  CaptureDetails(
      {this.id, this.name,
      required this.image, this.categoryId,
      required this.assetLocationId,
      required this.description,
      required this.quantity});

  CaptureDetails.fromMap(Map<String, dynamic> res)
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
