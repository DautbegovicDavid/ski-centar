
import 'package:skicentar_desktop/models/ski_accident.dart';
import 'package:skicentar_desktop/providers/base_provider.dart';

class SkiAccidentProvider extends BaseProvider<SkiAccident> {
  SkiAccidentProvider() : super("SkiAccident");

  @override
  SkiAccident fromJson(data) {
    return SkiAccident.fromJson(data);
  }
}
