import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:skicentar_desktop/models/lift.dart';
import 'package:skicentar_desktop/models/search_result.dart';
import 'package:skicentar_desktop/providers/base_provider.dart';
import 'package:skicentar_desktop/utils/api.helper.dart';
import 'package:skicentar_desktop/utils/auth.helper.dart';

class LiftProvider extends BaseProvider<Lift> {
  LiftProvider(): super("Lift");

  @override
  Lift fromJson(data) {
    return Lift.FromJson(data);
  }
}

// class LiftProvider {
//   static String? _baseUrl;
//   LiftProvider() {
//     _baseUrl = const String.fromEnvironment("baseUrl",
//         defaultValue: "http://localhost:5160/api/");
//   }

  // Future<SearchResult<Lift>> get() async {
  //   var url = "${_baseUrl}lift";
  //   var uri = Uri.parse(url);
  //   String token = await AuthHelper.getToken();
  //   var response = await http.get(uri, headers: ApiHelper.CreateHeaders(token));
   
  //   var items = jsonDecode(response.body)["resultList"].map((e)=>Lift.FromJson(e)).toList().cast<Lift>();

  //   SearchResult<Lift> result = SearchResult<Lift>();
  //   result.result = items;
  //   result.result = items;

  //   if (ApiHelper.isValidResponse(response)) {
  //     var data = jsonDecode(response.body);
  //     return data;
  //   } else {
  //     throw Exception("BELAJ");
  //   }
  // }
// }
