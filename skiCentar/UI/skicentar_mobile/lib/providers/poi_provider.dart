import 'package:skicentar_mobile/models/point_of_interest.dart';
import 'package:skicentar_mobile/providers/base_provider.dart';

class PoiProvider extends BaseProvider<PointOfInterest> {
  PoiProvider(): super("PointOfInterest");

  @override
  PointOfInterest fromJson(data) {
    return PointOfInterest.fromJson(data);
  }
}