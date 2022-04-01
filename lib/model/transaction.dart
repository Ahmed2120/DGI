class TransactionLookUp{
  final int? id;
  final String name;

  TransactionLookUp(
      { this.id,
        required this.name});

  TransactionLookUp.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name};
  }
}