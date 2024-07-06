import 'package:skicentar_mobile/models/login_model.dart';
import 'package:skicentar_mobile/models/register_model.dart';
import 'package:skicentar_mobile/models/verify_model.dart';
import 'package:skicentar_mobile/utils/api_helper.dart';
import 'package:skicentar_mobile/utils/auth_helper.dart';

class AuthProvider {
  static String? _baseUrl;
  AuthProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5160/api/Authentication");
  }

  static const String _loginEndpoint = '/login';
  static const String _registerEndpoint = '/register';
  static const String _verifyEndpoint = '/verifyUser';

  Future<dynamic> login(String email, String password) async {
    final response = await ApiHelper.post(_baseUrl!, _loginEndpoint,
        LoginModel(email: email, password: password));
    var isValidResposne = AuthHelper.isValidResponse(response);

    if (isValidResposne && response.statusCode == 200) {
      await AuthHelper.setToken(response);
      return true;
    } else {
      return isValidResposne;
    }
  }

  Future<dynamic> register(String email,String password) async {
    final response = await ApiHelper.post(
        _baseUrl!, _registerEndpoint, RegisterModel(email: email,password: password));
    var isValidResposne = AuthHelper.isValidResponse(response);

    if (isValidResposne && response.statusCode == 200) {
      return true;
    } else {
      return isValidResposne;
    }
  }

  Future<bool> verifyUser(String code) async {
    final response = await ApiHelper.post(
        _baseUrl!, _verifyEndpoint, Verify(verificationCode: code));
    var isValidResponse =  AuthHelper.isValidResponse(response);
     if (isValidResponse && response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
