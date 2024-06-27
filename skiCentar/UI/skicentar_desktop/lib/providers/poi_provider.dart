import 'package:skicentar_desktop/models/point_of_interest.dart';
import 'package:skicentar_desktop/providers/base_provider.dart';

class PoiProvider extends BaseProvider<PointOfInterest> {
  PoiProvider(): super("PointOfInterest");

  @override
  PointOfInterest fromJson(data) {
    return PointOfInterest.fromJson(data);
  }
}