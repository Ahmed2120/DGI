class Item {
  final int id;
  final String name;
  final int? accountGroupId;
  final int? itemType;
  bool hasMark;
  bool hasWidth;
  bool hasHeight;
  bool hasLength;

  Item({
    required this.id,
    required this.name,
    this.accountGroupId,
    this.itemType,
    this.hasMark = false,
    this.hasWidth = false,
    this.hasHeight = false,
    this.hasLength = false,
  });

  Item.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"],
        accountGroupId = res["AccountGroupId"],
        itemType = res["ItemType"],
        hasMark = res["HasMark"] == 0 ? false : true,
        hasWidth = res["HasWidth"] == 0 ? false : true,
        hasHeight = res["HasHeight"] == 0 ? false : true,
        hasLength = res["HasLength"] == 0 ? false : true;

  Map<String, Object?> toMap() {
    return {
      'Id': id,
      'Name': name,
      'AccountGroupId': accountGroupId,
      'ItemType': itemType,
      'HasMark': hasMark,
      'HasWidth': hasWidth,
      'HasHeight': hasHeight,
      'HasLength': hasLength,
    };
  }
}
