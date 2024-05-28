import 'package:skicentar_desktop/models/login_model.dart';
import 'package:skicentar_desktop/utils/api.helper.dart';
import 'package:skicentar_desktop/utils/auth.helper.dart';

class AuthProvider {
  
  static String? _baseUrl;
  AuthProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:5160/api/Authentication");
  }

  static const String _loginEndpoint = '/login';

  Future<dynamic> login(String email, String password) async {
    final response =await  ApiHelper.post(
        _baseUrl!, _loginEndpoint,LoginModel(email: email, password: password));

    var isValidResposne = AuthHelper.isValidResponse(response);

    if (isValidResposne && response.statusCode == 200) {
      await AuthHelper.setToken(response);
      return true;
    } else {
      return isValidResposne;
    }
  }
}
