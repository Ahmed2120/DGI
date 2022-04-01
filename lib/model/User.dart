class User {
  final int? id;
  final String name;
  final String username;
  final String password;
  final String address;
  final String? email;


  User(
      { this.id,
        required this.name,
        required this.username,
        required this.password,
        required this.address,
        required this.email});

  User.fromMap(Map<String, dynamic> res)
      : id = res["Id"],
        name = res["Name"],
        username = res["Username"],
        password = res["Password"],
        email = res["Email"],
        address = res["Address"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name, 'username': username, 'password': password, 'email': email,'address':address};
  }
}