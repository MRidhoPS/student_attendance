class Siswa {
  final int id;
  final String nim;
  final String name;

  Siswa({
    required this.id,
    required this.nim,
    required this.name,
  });

  factory Siswa.fromJson(Map<String, dynamic> json) {
    return Siswa(
      id: json['id'],
      nim: json['nim'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nim': nim,
      'name': name,
    };
  }
}
