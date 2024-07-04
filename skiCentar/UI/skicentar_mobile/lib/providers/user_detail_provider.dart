import 'package:skicentar_mobile/models/user_detail.dart';
import 'package:skicentar_mobile/providers/base_provider.dart';

class UserDetailProvider extends BaseProvider<UserDetail> {
  UserDetailProvider() : super("UserDetail");
  
  @override
  UserDetail fromJson(data) {
    return UserDetail.fromJson(data);
  }
}
