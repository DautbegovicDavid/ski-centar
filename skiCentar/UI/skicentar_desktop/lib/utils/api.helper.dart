import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:skicentar_desktop/utils/auth.helper.dart';

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

  static Map<String, String> CreateHeaders(String token) {
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
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
