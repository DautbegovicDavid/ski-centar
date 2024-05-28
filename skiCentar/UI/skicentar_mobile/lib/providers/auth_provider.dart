import 'package:skicentar_mobile/models/login_model.dart';
import 'package:skicentar_mobile/models/register_model.dart';
import 'package:skicentar_mobile/utils/api.helper.dart';
import 'package:skicentar_mobile/utils/auth.helper.dart';

class AuthProvider {
  
  static String? _baseUrl;
  AuthProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:5160/api/Authentication");
  }

  static const String _loginEndpoint = '/login';
  static const String _registerEndpoint = '/login';


  Future<dynamic> login(String email, String password) async {
    final response =await  ApiHelper.post(
        _baseUrl!, _loginEndpoint,LoginModel(email: email, password: password));
    print(response);
    var isValidResposne = AuthHelper.isValidResponse(response);

    if (isValidResposne && response.statusCode == 200) {
      await AuthHelper.setToken(response);
      return true;
    } else {
      return isValidResposne;
    }
  }

  Future<dynamic> register(String email) async {
    final response =await  ApiHelper.post(
        _baseUrl!, _registerEndpoint,RegisterModel(email: email));
    var isValidResposne = AuthHelper.isValidResponse(response);

    if (isValidResposne && response.statusCode == 200) {
      await AuthHelper.setToken(response);
      return true;
    } else {
      return isValidResposne;
    }
  }
}
