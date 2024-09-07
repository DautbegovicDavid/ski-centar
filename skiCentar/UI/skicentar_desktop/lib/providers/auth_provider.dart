import 'package:skicentar_desktop/models/login_model.dart';
import 'package:skicentar_desktop/providers/user_provider.dart';
import 'package:skicentar_desktop/utils/api.helper.dart';
import 'package:skicentar_desktop/utils/auth.helper.dart';

class AuthProvider {
  static String? _baseUrl;
  AuthProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:5160/api/");
  }

  static const String _loginEndpoint = 'Authentication/login';

  Future<dynamic> login(String email, String password) async {
    final response = await ApiHelper.post(_baseUrl!, _loginEndpoint,
        LoginModel(email: email, password: password));

    var isValidResposne = AuthHelper.isValidResponse(response);

    if (isValidResposne && response.statusCode == 200) {
      await AuthHelper.setToken(response);
      UserProvider userProvider = UserProvider();
      final user = await userProvider.getDetails();
      if (user.userRole?.name == 'Admin' || user.userRole?.name == 'Employee') {
        return true;
      } else {
        await AuthHelper.clearToken();
        throw Exception("You dont have permission to access system.");
      }
    } else {
      return isValidResposne;
    }
  }
}
