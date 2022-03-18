class Department{
  final int? id;
  final String name;

  Department(
      { this.id,
        required this.name});

  Department.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name};
  }
}