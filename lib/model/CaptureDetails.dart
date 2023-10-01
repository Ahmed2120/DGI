class CaptureDetails {
  final int? id;
  final String? name;
  final int quantity;
  final String description;
  final String? image;
  final int assetLocationId;
  final int itemId;
  final int? floorId;
  final int? departmentId;
  final int? sectionId;
  final int? brandId;
  final int? descriptionId;
  final int? colorId;
  final String? serialNumber;
  int? isUploaded;
  final double? height;
  final double? width;
  final double? length;
  final String? code;
  final String? ajehzaTamolkNumber;
  final String? cost;
  final String? serviceDate;
  final int? productionAge;
  final int? accumulatedConsumption;

  final String? transRefNumber;

  final String? supplierName;

  final String? transBoardNumber;

  final String? transCreationDate;

  final String? transType;

  final String? transHiekelNumbe;

  final String? transMamsha;

  final String? assetBookValue;
  final String? file;
  final String? fileName;
  final String? contentType;

  CaptureDetails({
    this.id,
    this.name,
    required this.image,
    required this.assetLocationId,
    required this.description,
    required this.quantity,
    required this.itemId,
    required this.departmentId,
    required this.floorId,
    required this.sectionId,
    required this.brandId,
    required this.descriptionId,
    required this.colorId,
    required this.serialNumber,
    this.isUploaded = 0,
    required this.length,
    required this.height,
    required this.width,
    this.code,
    this.ajehzaTamolkNumber,
    this.cost,
    this.serviceDate,
    this.productionAge,
    this.accumulatedConsumption,
    this.transRefNumber,
    this.supplierName,
    this.transBoardNumber,
    this.transCreationDate,
    this.transType,
    this.transHiekelNumbe,
    this.transMamsha,
    this.assetBookValue,
    this.file,
    this.fileName,
    this.contentType,
  });

  CaptureDetails.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"],
        quantity = res['Quantity'],
        description = res['Description'],
        image = res['Image'],
        assetLocationId = res['AssetLocationId'],
        itemId = res['ItemId'],
        floorId = res['FloorId'],
        departmentId = res['DepartmentId'],
        sectionId = res['SectionId'],
        brandId = res['BrandId'],
        descriptionId = res['DescriptionId'],
        colorId = res['ColorId'],
        serialNumber = res['SerialNumber'],
        isUploaded = res["isUploaded"],
        width = res["Width"] == null ? res["Width"] : res["Width"].toDouble(),
        height = res["height"] == null ? res["height"] : res["height"].toDouble(),
        length = res["length"] == null ? res["length"] : res["length"].toDouble(),
        code = res['Code'],
        ajehzaTamolkNumber = res['AjehzaTamolkNumber'],
        cost = res['Cost'],
        serviceDate = res['ServiceDate'],
        productionAge = res['productionAge'],
        accumulatedConsumption = res['AccumulatedConsumption'],
        transRefNumber = res['TransRefNumber'],
        supplierName = res['SupplierName'],
        transBoardNumber = res["TransBoardNumber"],
        transCreationDate = res["TransCreationDate"],
        transType = res["TransType"],
        transHiekelNumbe = res["TransHiekelNumbe"],
        transMamsha = res["TransMamsha"],
        assetBookValue = res["AssetBookValue"],
        file = res["File"],
        fileName = res["FileName"],
        contentType = res["ContentType"];

  Map<String, Object?> toMap() {
    return {
      'Id': id,
      'Name': name,
      'AssetLocationId': assetLocationId,
      'ItemId': itemId,
      'Description': description,
      'Quantity': quantity,
      'FloorId': floorId,
      'DepartmentId': departmentId,
      'SectionId': sectionId,
      'BrandId': brandId,
      'DescriptionId': descriptionId,
      'ColorId': colorId,
      'SerialNumber': serialNumber,
      'isUploaded': isUploaded,
      'Width': width,
      'Height': height,
      'Length': length,
      'Image': image,
      'Code' : code,
      'AjehzaTamolkNumber' : ajehzaTamolkNumber,
      'Cost' : cost,
      'ServiceDate' : serviceDate,
      'productionAge' : productionAge,
      'AccumulatedConsumption' : accumulatedConsumption,
      'TransRefNumber' : transRefNumber,
      'SupplierName' : supplierName,
      'TransBoardNumber' : transBoardNumber,
      'TransCreationDate' : transCreationDate,
      'TransType' : transType,
      'TransHiekelNumbe' : transHiekelNumbe,
      'TransMamsha' : transMamsha,
      'AssetBookValue' : assetBookValue,
      'File' : file,
      'FileName' : fileName,
      'ContentType' : contentType,
    };
  }
}
