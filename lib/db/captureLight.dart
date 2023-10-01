class CaptureLight {
  final int? id;
  final String? name;
  final int quantity;
  final String description;
  final String? image;
  final int itemId;
  final int? floorId;
  final int? sectionId;
  final int? transactionId;
  final int? descriptionId;


  CaptureLight({
    this.id,
    this.name,
    this.image,
    required this.description,
    required this.quantity,
    required this.itemId,
    required this.floorId,
    required this.sectionId,
    required this.transactionId,
    required this.descriptionId,
  });

  CaptureLight.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"],
        quantity = res['Quantity'],
        description = res['Description'],
        image = res['ItemImage'],
        itemId = res['ItemId'],
        floorId = res['FloorId'],
        sectionId = res['SectionId'],
  transactionId = res['TransactionId'],
        descriptionId = res['DescriptionId'];

  Map<String, Object?> toMap() {
    return {
      'Id': id,
      'Name': name,
      'ItemId': itemId,
      'Description': description,
      'Quantity': quantity,
      'FloorId': floorId,
      'SectionId': sectionId,
      'ItemImage': image,
      'TransactionId': transactionId,
      'DescriptionId': descriptionId,
    };
  }
}
