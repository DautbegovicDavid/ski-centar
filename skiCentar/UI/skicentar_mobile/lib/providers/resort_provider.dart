import 'package:skicentar_mobile/models/resort.dart';
import 'package:skicentar_mobile/providers/base_provider.dart';

class ResortProvider extends BaseProvider<Resort> {
  ResortProvider() : super("Resort");
  Resort? _selectedResort;

  Resort? get selectedResort => _selectedResort;

  void selectResort(Resort resort) {
    _selectedResort = resort;
    notifyListeners();
  }

  void clearResort() {
    _selectedResort = null;
    notifyListeners();
  }

  @override
  Resort fromJson(data) {
    return Resort.fromJson(data);
  }
}
