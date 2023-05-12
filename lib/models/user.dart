class User {
  final String name;
  final String username;
  final String pass;

  User({required this.name, required this.username, required this.pass});

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      name: data["name"],
      username: data["username"],
      pass: data["pass"],
    );
  }
}
