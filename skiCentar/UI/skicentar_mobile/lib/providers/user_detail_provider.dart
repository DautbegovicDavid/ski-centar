import 'package:skicentar_mobile/models/user_detail.dart';
import 'package:skicentar_mobile/providers/base_provider.dart';

class UserDetailProvider extends BaseProvider<UserDetail> {
  UserDetailProvider() : super("UserDetail");
  UserDetail? _userDetails;

  UserDetail? get userDetails => _userDetails;

  void setUserDetails(UserDetail userDetail) {
    _userDetails = userDetail;
    notifyListeners();
  }

  void clearUserDetails() {
    _userDetails = null;
    notifyListeners();
  }

  @override
  UserDetail fromJson(data) {
    return UserDetail.fromJson(data);
  }
}
