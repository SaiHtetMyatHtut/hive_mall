import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthServices {
  static String baseUri = "https://assessment-api.hivestage.com";
  static Future<http.Response> loginService(
      String username, String password) async {
    http.Response response =
        await http.post(Uri.parse(baseUri + "/api/auth/login"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({"username": username, "password": password}));
    return response;
  }
}
