import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:skicentar_desktop/utils/api.helper.dart';
import 'package:skicentar_desktop/utils/auth.helper.dart';

class LiftProvider {
  static String? _baseUrl;
  LiftProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:5160/api/");
  }

  Future<dynamic> get() async {
    var url = "${_baseUrl}lift";
    var uri = Uri.parse(url);
    String token = await AuthHelper.getToken();
    var response = await http.get(uri, headers: ApiHelper.CreateHeaders(token));

    if (ApiHelper.isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("BELAJ");
    }
  }


}
