class Asset {
  final int? id;
  final int? itemId;
  final String barcode;
  final String barcodeImage;
  final String serialnumber;
  final int assetLocationId;
  final String description;
  final String image;

  Asset(
      { this.id,
        required this.itemId,
        required this.barcode,
        required this.barcodeImage,
        required this.serialnumber,
        required this.assetLocationId,
        required this.description,
        required this.image,});

  Asset.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        itemId = res["itemId"],
        barcode = res["barcode"],
        barcodeImage = res["barcodeImage"],
        serialnumber = res["serialnumber"],
        assetLocationId = res["assetLocationId"],
        description = res["description"],
        image = res["image"];

  Map<String, Object?> toMap() {
    return {'id':id,'itemId': itemId, 'barcode': barcode, 'barcodeImage': barcodeImage,
      'serialnumber':serialnumber,'assetLocationId':assetLocationId,'description':description ,
      'image':image};
  }
}