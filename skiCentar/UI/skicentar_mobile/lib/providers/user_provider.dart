import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:skicentar_mobile/models/user.dart';
import 'package:skicentar_mobile/providers/base_provider.dart';
import 'package:skicentar_mobile/utils/api_helper.dart';
import 'package:skicentar_mobile/utils/auth_helper.dart';

class UserProvider extends BaseProvider<User> {
  final String _baseUrl = const String.fromEnvironment("baseUrl",
      defaultValue: "http://10.0.2.2:5160/api/");

  UserProvider() : super("User");

  User? _currentUser;

  User? get currentUser => _currentUser;

  void setUser(User user) {
    print("USER ->>>>> $user");
    _currentUser = user;
    notifyListeners();
  }

  @override
  User fromJson(data) {
    return User.fromJson(data);
  }

  Future<User> getDetails() async {
    var url = "${_baseUrl}User/info";
    var uri = Uri.parse(url);
    String token = await AuthHelper.getToken();

    var response = await http.get(uri, headers: ApiHelper.createHeaders(token));
    print(response.body);
    if (response.statusCode == 200) {
      return fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<User> createEmployee(dynamic obj) async {
    var endpoint = "User/employee";
    return insert(obj, endpoint: endpoint);
  }

  Future<User> updateEmployee(dynamic obj) async {
    var endpoint = "User/employee";
    return insert(obj, endpoint: endpoint);
  }
}
