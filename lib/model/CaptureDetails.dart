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
      : id = res["Id"],
        name = res["Name"],
        categoryId = res['CategoryId'],
        quantity = res['Quantity'],
        description = res['Description'],
        image = res['Image'],
        assetLocationId = res['AssetLocationId'];

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name,'image':image,'categoryId':categoryId,'assetLocationId':assetLocationId,
      'description':description,'quantity':quantity};
  }
}
