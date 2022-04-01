class Asset {
  final int id;
  final int itemId;
  final String barcode;
  final String barcodeImage;
  final String serialnumber;
  final int assetLocationId;
  final String description;
  final String image;
  int correct;
  int isCounted;
  int isVerified;

  Asset(
      { required this.id,
        required this.itemId,
        required this.barcode,
        required this.barcodeImage,
        required this.serialnumber,
        required this.assetLocationId,
        required this.description,
        required this.image,
        this.correct=0,
        this.isCounted=0,
        this.isVerified=0});

  Asset.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        itemId = res["ItemId"],
        barcode = res["Barcode"],
        barcodeImage = res["BarcodeImage"],
        serialnumber = res["Serialnumber"],
        assetLocationId = res["AssetLocationId"],
        description = res["Description"],
        image = res["Image"],
        correct = res["correct"],
        isVerified = res["isVerified"],
        isCounted = res["isCounted"];

  Map<String, Object?> toMap() {
    return {'Id':id,'ItemId': itemId, 'Barcode': barcode, 'BarcodeImage': barcodeImage,
      'Serialnumber':serialnumber,'AssetLocationId':assetLocationId,'Description':description ,
      'Image':image,'correct':correct,'isVerified':isVerified,'isCounted':isCounted};
  }
}