class Department{
  final int? id;
  final String name;

  Department(
      { this.id,
        required this.name});

  Department.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name};
  }
}