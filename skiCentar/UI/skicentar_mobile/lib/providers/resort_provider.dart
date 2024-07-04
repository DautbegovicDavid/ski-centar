import 'package:skicentar_mobile/models/resort.dart';
import 'package:skicentar_mobile/providers/base_provider.dart';

class ResortProvider extends BaseProvider<Resort> {
  ResortProvider() : super("Resort");
  Resort? _selectedResort;

  Resort? get selectedResort => _selectedResort;

  void selectResort(Resort resort) {
    _selectedResort = resort;
    print(_selectedResort!.name.toString());
    notifyListeners();
  }

  @override
  Resort fromJson(data) {
    return Resort.fromJson(data);
  }
}
