import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_desktop/components/dropdown_field.dart';
import 'package:skicentar_desktop/components/input_field.dart';
import 'package:skicentar_desktop/components/table_wrapper.dart';
import 'package:skicentar_desktop/layouts/master_screen.dart';
import 'package:skicentar_desktop/models/poi_category.dart';
import 'package:skicentar_desktop/models/point_of_interest.dart';
import 'package:skicentar_desktop/models/resort.dart';
import 'package:skicentar_desktop/models/search_result.dart';
import 'package:skicentar_desktop/providers/poi_category_provider.dart';
import 'package:skicentar_desktop/providers/poi_provider.dart';
import 'package:skicentar_desktop/providers/resort_provider.dart';
import 'package:skicentar_desktop/screens/poi_add_screen.dart';

class PoiListScreen extends StatefulWidget {
  const PoiListScreen({super.key});
  @override
  State<PoiListScreen> createState() => _PoiListScreenState();
}

class _PoiListScreenState extends State<PoiListScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final Map<String, dynamic> _initialValue = {};

  SearchResult<PointOfInterest>? result;
  List<Resort> _resorts = [];
  List<PoiCategory> _poiCategories = [];

  late PoiProvider provider;
  late ResortProvider resortProvider;
  late PoiCategoryProvider poiCategoryProvider;

  var filter = {
    'isResortIncluded': true,
    'isCategoryIncluded': true,
  };

  @override
  void initState() {
    provider = context.read<PoiProvider>();
    resortProvider = context.read<ResortProvider>();
    poiCategoryProvider = context.read<PoiCategoryProvider>();
    super.initState();
    provider.addListener(_fetchData);
    _fetchData();
  }

  Future _fetchData() async {
    result = await provider.get(filter: filter);
    var resorts = await resortProvider.get(filter: {});
    _resorts = resorts.result;
    var liftTypes = await poiCategoryProvider.get(filter: {});
    _poiCategories = liftTypes.result;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Point of Interests",
        Column(
          children: [_buildSearch(), _buildResultView()],
        ),
        false,
        true);
  }

  Widget _buildSearch() {
    return Card(
      margin: const EdgeInsets.all(10.0),
      elevation: 2.0,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FormBuilder(
          key: _formKey,
          initialValue: _initialValue,
          child: Row(
            children: [
              const InputField(
                name: "NameGTE",
                labelText: "Name",
              ),
              const SizedBox(width: 12),
              DropdownField(
                name: "categoryId",
                labelText: "Category",
                items: _poiCategories
                    .map((item) => DropdownMenuItem<String>(
                        value: item.id.toString(),
                        child: Text(item.name ?? "")))
                    .toList(),
              ),
              const SizedBox(width: 12),
              DropdownField(
                name: "resortId",
                labelText: "Resort",
                items: _resorts
                    .map((item) => DropdownMenuItem<String>(
                        value: item.id.toString(),
                        child: Text(item.name ?? "")))
                    .toList(),
              ),
              const Spacer(),
              if (_formKey.currentState?.isDirty ?? false)
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () async {
                    _formKey.currentState?.reset();
                    result = await provider.get(filter: filter);
                    setState(() {});
                  },
                ),
              FilledButton(
                onPressed: _search,
                child: const Text("Search"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _search() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      var formValues = _formKey.currentState?.value ?? {};
      var combinedFilter = {
        ...filter,
        ...formValues,
      };
      result = await provider.get(filter: combinedFilter);
      setState(() {});
    }
  }

  void _navigateToEditPage(
      BuildContext context, PointOfInterest pointOfInterest) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PoiAddScreen(pointOfInterest: pointOfInterest)),
    );
  }

  Widget _buildResultView() {
    return TableWrapper(
      columns: const [
        DataColumn(label: Text("Id"), numeric: true),
        DataColumn(label: Text("Name")),
        DataColumn(label: Text("Resort")),
        DataColumn(label: Text("Category")),
        DataColumn(label: Text("Description")),
        DataColumn(label: Text('Actions')),
      ],
      rows: result?.result
              .map((m) => DataRow(cells: [
                    DataCell(Text(m.id.toString())),
                    DataCell(Text(m.name!)),
                    DataCell(Text(m.resort?.name ?? m.resortId.toString())),
                    DataCell(Text(m.category?.name ?? m.category!.toString())),
                    DataCell(Text(m.description.toString())),
                    DataCell(
                      ElevatedButton(
                        onPressed: () => _navigateToEditPage(context, m),
                        child: const Text('Edit'),
                      ),
                    ),
                  ]))
              .toList()
              .cast<DataRow>() ??
          [],
    );
  }
}
