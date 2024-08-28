import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginController {
  final String url = 'http://localhost:2000/api/login';

  Future<Map<String, dynamic>> loginAccount(
      String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            'username': username,
            'password': password,
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseLogin = jsonDecode(response.body);
        return responseLogin;
      } else {
        throw Exception('Gagal Login akun');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat mencoba login akun');
    }
  }
}
