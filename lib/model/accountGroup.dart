class AccountGroup{
  final int? id;
  final String name;
  final int? categoryId;

  AccountGroup(
      { required this.id,
        required this.name,
        this.categoryId});

  AccountGroup.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"],
        categoryId = res['ParentId'];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name, 'ParentId': categoryId};
  }
}