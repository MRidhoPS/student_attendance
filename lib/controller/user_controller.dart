import 'dart:convert';

import 'package:absensi_siswa/model/absen_model.dart';
import 'package:absensi_siswa/model/siswa_model.dart';
import 'package:absensi_siswa/model/status_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class UserController {
  // final String baseUrl = 'http://10.0.2.2:2000/api/siswa'; // untuk mobile pake 10.0.2.2
  final String baseUrl =
      'http://localhost:2000/api/siswa'; // untuk web pake localhost


  Future<List<Siswa>> getSiswaList() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonRes = jsonDecode(response.body);
      List<dynamic> data = jsonRes['data'];
      List<Siswa> result = data.map((e) => Siswa.fromJson(e)).toList();
      return result;
    } else {
      throw Exception('Failed to load Siswa');
    }
  }



  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  Future<void> postAbsen(Attendance attendance) async {
    const String url = 'http://localhost:2000/api/siswa/attendance';

    try {
      // Format the date to match 'YYYY-MM-DD'
      final formattedDate = formatDate(DateTime.now());

      // Create a map with the formatted date
      final Map<String, dynamic> body = {
        'student_id': attendance.studentId,
        'date': formattedDate,
        'status': attendance.status,
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );


      if (response.statusCode == 200) {
      } else if (response.statusCode == 404) {
        throw Exception('Absen sudah dilakukan untuk hari ini');
      } else {
        throw Exception('Gagal menyisipkan data');
      }
    } catch (e) {
      
      throw Exception('Terjadi kesalahan saat mencoba menyisipkan data');
    }
  }


  Future<List<StatusSiswa>> fetchAttendanceByDate(dynamic date) async {
    final String url = 'http://localhost:2000/api/siswa/getData/$date';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
      return jsonResponse.map((data) => StatusSiswa.fromJson(data)).toList();
    } else {
      throw Exception('No Data');
    }
  }
}
