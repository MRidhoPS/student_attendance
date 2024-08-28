class StatusSiswa {
  final String name;
  final String nim;
  final String status;

  StatusSiswa({required this.name, required this.nim, required this.status});

  factory StatusSiswa.fromJson(Map<String, dynamic> json) {
    return StatusSiswa(
        name: json['name'], nim: json['nim'], status: json['status']);
  }
}
