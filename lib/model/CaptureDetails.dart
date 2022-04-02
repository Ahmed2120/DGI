class CaptureDetails {
  final int? id;
  final String? name;
  final int quantity;
  final String description;
  final String image;
  final int assetLocationId;
  final int itemId;

  CaptureDetails(
      {this.id, this.name,
      required this.image,
      required this.assetLocationId,
      required this.description,
      required this.quantity,
      required this.itemId});

  CaptureDetails.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"],
        quantity = res['Quantity'],
        description = res['Description'],
        image = res['Image'],
        assetLocationId = res['AssetLocationId'],
        itemId = res['ItemId'];

  Map<String, Object?> toMap() {
    return {'Id': id, 'Name': name,'Image':image,'AssetLocationId':assetLocationId, 'ItemId':itemId,
      'Description':description,'Quantity':quantity};
  }
}
