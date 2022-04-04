class CaptureDetailsRequest {
  final int? id;
  final int quantity;
  final String description;
  final String image;
  final int assetLocationId;
  final int itemId;
  final int transactionId;

  CaptureDetailsRequest(
      {this.id,
      required this.image,
      required this.assetLocationId,
      required this.description,
      required this.quantity,
      required this.itemId,required this.transactionId});

  CaptureDetailsRequest.fromJson(Map<String, dynamic> res)
      : id = res["Id"],
        quantity = res['Quantity'],
        description = res['Description'],
        image = res['ItemImage'],
        assetLocationId = res['AssetLocationId'],
        itemId = res['ItemId'],
        transactionId = res['TransactionId'];

  Map<String, Object?> toJson() {
    return {'Id': id,'ItemImage':image,'AssetLocationId':assetLocationId, 'ItemId':itemId,
      'Description':description,'Quantity':quantity,'TransactionId':transactionId};
  }
}
