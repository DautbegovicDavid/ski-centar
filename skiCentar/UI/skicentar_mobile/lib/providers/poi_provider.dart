import 'package:skicentar_mobile/models/point_of_interest.dart';
import 'package:skicentar_mobile/providers/base_provider.dart';
import 'package:skicentar_mobile/utils/api_helper.dart';
import 'package:skicentar_mobile/utils/auth_helper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PoiProvider extends BaseProvider<PointOfInterest> {
  PoiProvider(): super("PointOfInterest");

  @override
  PointOfInterest fromJson(data) {
    return PointOfInterest.fromJson(data);
  }

  Future<List<PointOfInterest>> getRecommendedPois(int id) async {
    var url = "${BaseProvider.baseUrl}Recommendations/$id";
    var uri = Uri.parse(url);
    String token = await AuthHelper.getToken();
    var response = await http.get(uri, headers: ApiHelper.createHeaders(token));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
    return data.map((item) => fromJson(item)).toList();
    } else {
      throw Exception('Failed to load pois');
    }
  }
}