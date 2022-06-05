class Description{
  final int id;
  final String name;
  final int? itemId;

  Description(
      {required this.id,
        required this.name,
        this.itemId});

  Description.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"],
        itemId=res["ItemId"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name,'ItemId':itemId};
  }
}