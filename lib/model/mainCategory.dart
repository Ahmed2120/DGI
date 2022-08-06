class MainCategory{
  final int? id;
  final String name;
  final int? levelId;

  MainCategory(
      { required this.id,
        required this.name,
        this.levelId});

  MainCategory.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"],
        levelId = res["ParentId"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name, 'ParentId': levelId};
  }
}