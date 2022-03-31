class TransactionLookUp{
  final int? id;
  final String name;

  TransactionLookUp(
      { this.id,
        required this.name});

  TransactionLookUp.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name};
  }
}