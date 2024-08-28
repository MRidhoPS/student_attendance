class Attendance {
  final int studentId;
  final String date;
  final String status;

  Attendance({
    required this.studentId,
    required this.date,
    required this.status,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      studentId: json['student_id'],
      date: json['date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'date': date,
      'status': status,
    };
  }
}
