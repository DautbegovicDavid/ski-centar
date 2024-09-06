import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiHelper {

  static Map<String, String> createHeaders(String token) {
    var header = {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $token'
    };
    return header;
  }

  static Future<Response> post(
      String baseUrl, String enpoint, Object object) async {
    final response = await http.post(
      Uri.parse(baseUrl + enpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(object),
    );
    return response;
  }
}
