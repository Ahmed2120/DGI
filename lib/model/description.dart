class Description{
  final int id;
  final String description;
  final int? itemId;

  Description(
      {required this.id,
        required this.description,
        this.itemId});

  Description.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        description = res["Description"],
        itemId=res["ItemId"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Description': description,'ItemId':itemId};
  }
}


class DescriptionLight{
  final int id;
  final String description;
  final int? itemId;

  DescriptionLight(
      {required this.id,
        required this.description,
        this.itemId});

  DescriptionLight.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        description = res["Name"],
        itemId=res["ItemId"];


}