import 'package:skicentar_desktop/models/lift-type.dart';
import 'package:skicentar_desktop/providers/base_provider.dart';

class LiftTypeProvider extends BaseProvider<LiftType> {
  LiftTypeProvider(): super("LiftType");

  @override
  LiftType fromJson(data) {
    return LiftType.fromJson(data);
  }
}