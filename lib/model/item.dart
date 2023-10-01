class Item {
  final int id;
  final String name;
  final int? accountGroupId;
  final int? itemType;
  int hasMark;
  int hasWidth;
  int hasHeight;
  int hasLength;

  Item({
    required this.id,
    required this.name,
    this.accountGroupId,
    this.itemType,
    this.hasMark = 0,
    this.hasWidth = 0,
    this.hasHeight = 0,
    this.hasLength = 0,
  });

  Item.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"],
        accountGroupId = res["AccountGroupId"],
        itemType = res["ItemType"],
        hasMark = res["HasMark"] == false || res["HasMark"] == 0 ? 0 : 1,
        hasWidth = res["HasWidth"] == false || res["HasWidth"] == 0 ? 0 : 1,
        hasHeight = res["HasHeight"] == false || res["HasHeight"] == 0 ? 0 : 1,
        hasLength = res["HasLength"] == false || res["HasLength"] == 0  ? 0 : 1;

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
