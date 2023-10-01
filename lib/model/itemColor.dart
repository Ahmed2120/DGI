class ItemColor{
  final int? id;
  final String name;

  ItemColor(
      { this.id,
        required this.name,});

  ItemColor.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name};
  }
}