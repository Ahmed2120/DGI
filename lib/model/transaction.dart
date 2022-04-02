class TransactionLookUp{
  final int id;
  final int transactionType;
  final String transActionTypeName;

  TransactionLookUp(
      { required this.id,
        required this.transactionType,
        required this.transActionTypeName});

  TransactionLookUp.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        transactionType = res["TransactionType"],
        transActionTypeName = res["TransActionTypeName"];

  Map<String, Object?> toMap() {
    return {'Id':id,'TransActionTypeName':transActionTypeName,'TransactionType':transactionType};
  }
}