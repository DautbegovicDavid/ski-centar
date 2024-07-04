import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiHelper {
  static bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw Exception("Unautorized");
    } else {
      throw Exception("Something bad happended, please try again!");
    }
  }

  static Map<String, String> createHeaders(String token) {
    var header = {"Content-Type": "application/json", "Authorization": 'Bearer $token'};
    return header;
  }

  static Future<Response> post(
      String baseUrl, String enpoint, Object object) async {
    print(Uri.parse(baseUrl + enpoint));
    final response = await http.post(
      Uri.parse(baseUrl + enpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(object),
    );
    print(response);
    return response;
  }
}
