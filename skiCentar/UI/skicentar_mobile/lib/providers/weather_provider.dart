import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:skicentar_mobile/providers/base_provider.dart';
import 'package:skicentar_mobile/utils/api_helper.dart';
import 'package:skicentar_mobile/utils/auth_helper.dart';
import 'package:http/http.dart' as http;

class WeatherProvider with ChangeNotifier {
  Future<Map<String, dynamic>> fetchWeather(
      String mountain, String city) async {
    var url = "${BaseProvider.baseUrl}Weather/?mountain=$mountain&city=$city";

    final response = await _geta(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<Response> _geta(String url) async {
    String token = await AuthHelper.getToken();
    var uri = Uri.parse(url);
    var headers = ApiHelper.createHeaders(token);

    var response = await http.get(uri, headers: headers);

    if (!AuthHelper.isValidResponse(response)) {
      throw Exception("Unknown error");
    }
    return response;
  }
}