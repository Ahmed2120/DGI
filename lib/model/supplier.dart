class Supplier{
  final int? id;
  final String name;

  Supplier(
      { required this.id,
        required this.name});

  Supplier.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name};
  }
}