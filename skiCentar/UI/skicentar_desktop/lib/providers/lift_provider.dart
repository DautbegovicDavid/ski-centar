import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:skicentar_desktop/models/lift.dart';
import 'package:skicentar_desktop/providers/base_provider.dart';
import 'package:skicentar_desktop/utils/auth.helper.dart';

class LiftProvider extends BaseProvider<Lift> {
  LiftProvider() : super("Lift");
  
  @override
  Lift fromJson(data) {
    return Lift.fromJson(data);
  }

  Future<List<String>> getAllowedActions(int id) async {
    var url = "${BaseProvider.baseUrl}Lift/$id/allowedActions";
    var response = await _geta(url);
    var data = jsonDecode(response.body) as List<dynamic>;
    return data.cast<String>();
  }

  Future<Response> _geta(String url) async {
    String token = await AuthHelper.getToken();
    var uri = Uri.parse(url);
    var headers = createHeaders(token);

    var response = await http.get(uri, headers: headers);

    if (!isValidResponse(response)) {
      throw Exception("Unknown error");
    }
    return response;
  }

  Future<void> activate(int id) async {
    var url = "${BaseProvider.baseUrl}Lift/$id/activate";
    await putWithoutBody(url);
  }

  Future<void> hide(int id) async {
    var url = "${BaseProvider.baseUrl}Lift/$id/hide";
    await putWithoutBody(url);
  }

  Future<void> edit(int id) async {
    var url = "${BaseProvider.baseUrl}Lift/$id/edit";
    await putWithoutBody(url);
  }
}
