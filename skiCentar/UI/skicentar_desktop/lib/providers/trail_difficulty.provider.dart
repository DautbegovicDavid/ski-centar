import 'package:skicentar_desktop/models/trail_difficulty.dart';
import 'package:skicentar_desktop/providers/base_provider.dart';

class TrailDifficultyProvider extends BaseProvider<TrailDifficulty> {
  TrailDifficultyProvider(): super("TrailDifficulty");

  @override
  TrailDifficulty fromJson(data) {
    return TrailDifficulty.fromJson(data);
  }
}