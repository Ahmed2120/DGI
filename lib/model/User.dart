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
      : id = res["id"],
        name = res["name"],
        username = res["username"],
        password = res["password"],
        email = res["email"],
        address = res["address"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name, 'username': username, 'password': password, 'email': email,'address':address};
  }
}