import 'package:skicentar_desktop/models/user-role.dart';
import 'package:skicentar_desktop/providers/base_provider.dart';

class UserRoleProvider extends BaseProvider<UserRole> {
  UserRoleProvider(): super("UserRole");

  @override
  UserRole fromJson(data) {
    return UserRole.fromJson(data);
  }
}