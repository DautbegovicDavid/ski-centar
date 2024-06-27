import 'package:skicentar_desktop/models/poi_category.dart';
import 'package:skicentar_desktop/providers/base_provider.dart';

class PoiCategoryProvider extends BaseProvider<PoiCategory> {
  PoiCategoryProvider(): super("PointOfInterestCategory");

  @override
  PoiCategory fromJson(data) {
    return PoiCategory.fromJson(data);
  }
}