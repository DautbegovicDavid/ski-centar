import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Create storage
class AuthHelper {

  static String? _baseUrl;
  AuthHelper() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:5160/api/");
  }

  static bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw Exception("Unautorized");
    } else {
      throw Exception("Something bad happended, please try again!");
    }
  }

  static Future setToken(Response response) async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonDecode(response.body);
    await prefs.setString('token', data['token']);
  }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token')!;
  }

  static Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
