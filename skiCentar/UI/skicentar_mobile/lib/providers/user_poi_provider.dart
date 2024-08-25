import 'package:skicentar_mobile/models/user_poi.dart';
import 'package:skicentar_mobile/providers/base_provider.dart';

class UserPoiProvider extends BaseProvider<UserPoi> {
  UserPoiProvider() : super("UserPoi");
  
  @override
  UserPoi fromJson(data) {
    return UserPoi.fromJson(data);
  }
}
