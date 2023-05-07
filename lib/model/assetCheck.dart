class AssetCheck{
  final int? id;
  final String barcode;
  final String sectionName;
  int sectionId;
  int? isChecked;

  AssetCheck(
      { this.id,
        required this.barcode,
        required this.sectionName,
        required this.sectionId,
        this.isChecked = 0,
      });

  AssetCheck.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        barcode = res["Barcode"],
        sectionName = res["SectionName"],
        sectionId = res["SectionId"],
        isChecked = res["IsChecked"];

  Map<String, Object?> toJson() {
    return {'Id':id,'Barcode': barcode,'SectionName': sectionName,'SectionId':sectionId,'IsChecked':isChecked};
  }
}