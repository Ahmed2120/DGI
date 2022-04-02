class User {
  final int? id;
  final String? name;
  final String username;
  final String password;
  final String? address;
  final String? email;


  User(
      { this.id,
        this.name,
        required this.username,
        required this.password,
        this.address,
        required this.email});

  User.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"],
        username = res["UserName"],
        password = res["HashedPassword"],
        email = res["Email"],
        address = res["Address"];

  Map<String, Object?> toMap() {
    return {'Id':id,'Name': name, 'UserName': username, 'HashedPassword': password, 'EmailAddress': email,'Address':address};
  }
}