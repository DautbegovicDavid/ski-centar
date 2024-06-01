import 'package:skicentar_desktop/models/lift.dart';
import 'package:skicentar_desktop/models/search_result.dart';
import 'package:skicentar_desktop/providers/lift_provider.dart';

class LoggedLiftProvider extends LiftProvider{
  @override
  Future<SearchResult<Lift>> get({filter}) {
    print("loger majka");
    // TODO: implement get
    return super.get(filter:filter);
  }

}