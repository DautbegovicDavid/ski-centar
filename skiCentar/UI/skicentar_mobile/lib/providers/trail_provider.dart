import 'package:skicentar_mobile/models/trail.dart';
import 'package:skicentar_mobile/providers/base_provider.dart';

class TrailProvider extends BaseProvider<Trail> {
  TrailProvider() : super("Trail");
  
  @override
  Trail fromJson(data) {
    return Trail.fromJson(data);
  }
}
