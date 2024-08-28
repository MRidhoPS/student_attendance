class Guru {
  final int id;
  final String username;
  final String password;
  final String name;

  Guru({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
