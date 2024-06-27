import 'package:skicentar_desktop/models/resort.dart';
import 'package:skicentar_desktop/providers/base_provider.dart';

class ResortProvider extends BaseProvider<Resort> {
  ResortProvider(): super("Resort");

  @override
  Resort fromJson(data) {
    return Resort.fromJson(data);
  }
}