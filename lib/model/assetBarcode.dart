class AssetBarcode{
  final int id;
  final String? barcode;
  final String? imageInBase64;
  final String? sectionName;
  final String? floorName;

  AssetBarcode(
      { required this.id,
        required this.barcode,
        required this.imageInBase64,
        required this.sectionName,
        required this.floorName,
      });

  AssetBarcode.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        barcode = res["Barcode"],
        imageInBase64 = res["ImageInBase64"],
        sectionName = res["SectionName"],
        floorName = res["FloorName"];

}