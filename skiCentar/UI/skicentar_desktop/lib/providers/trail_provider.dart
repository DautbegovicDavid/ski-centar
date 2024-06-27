import 'package:skicentar_desktop/models/trail.dart';
import 'package:skicentar_desktop/providers/base_provider.dart';

class TrailProvider extends BaseProvider<Trail> {
  TrailProvider() : super("Trail");
  
  @override
  Trail fromJson(data) {
    return Trail.fromJson(data);
  }
}
