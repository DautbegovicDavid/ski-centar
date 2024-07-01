import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_desktop/components/dropdown_field.dart';
import 'package:skicentar_desktop/components/input_field.dart';
import 'package:skicentar_desktop/components/table_wrapper.dart';
import 'package:skicentar_desktop/layouts/master_screen.dart';
import 'package:skicentar_desktop/models/resort.dart';
import 'package:skicentar_desktop/models/search_result.dart';
import 'package:skicentar_desktop/models/trail.dart';
import 'package:skicentar_desktop/models/trail_difficulty.dart';
import 'package:skicentar_desktop/providers/resort_provider.dart';
import 'package:skicentar_desktop/providers/trail_difficulty.provider.dart';
import 'package:skicentar_desktop/providers/trail_provider.dart';
import 'package:skicentar_desktop/screens/trail_add_screen.dart';

class TrailListScreen extends StatefulWidget {
  const TrailListScreen({super.key});

  @override
  State<TrailListScreen> createState() => _TrailListScreenState();
}

class _TrailListScreenState extends State<TrailListScreen> {
  SearchResult<Trail>? result;
  late TrailProvider provider;
  late ResortProvider resortProvider;
  late TrailDifficultyProvider trailDifficultyProvider;

  final _formKey = GlobalKey<FormBuilderState>();
  final Map<String, dynamic> _initialValue = {};
  var filter = {
    'isResortIncluded': true,
    'isDifficultyIncluded': true,
    'areTrailLocationsIncluded': true,
  };

  List<Resort> _resorts = [];
  List<TrailDifficulty> _trailDifficulties = [];

  @override
  void initState() {
    provider = context.read<TrailProvider>();
    resortProvider = context.read<ResortProvider>();
    trailDifficultyProvider = context.read<TrailDifficultyProvider>();
    super.initState();
    provider.addListener(_fetchData);
    _fetchData();
  }

  Future _fetchData() async {
    result = await provider.get(filter: filter);
    var resorts = await resortProvider.get(filter: {});
    _resorts = resorts.result;
    var trailDifficulties = await trailDifficultyProvider.get(filter: {});
    _trailDifficulties = trailDifficulties.result;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Ski Tracks",
        Column(
          children: [_buildSearch(), _buildResultView()],
        ),
        false,
        true);
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
                name: "difficultyId",
                labelText: "Trail Difficulty",
                items: _trailDifficulties
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

  void navigateToEditPage(BuildContext context, Trail trail) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TrailAddScreen(trail: trail)),
    );
  }

  Widget _buildResultView() {
    return TableWrapper(
      columns: const [
        DataColumn(label: Text("Id"), numeric: true),
        DataColumn(label: Text("Name")),
        DataColumn(label: Text("Resort")),
        DataColumn(label: Text("Difficulty")),
        DataColumn(label: Text("Functional")),
        DataColumn(label: Text("Length")),
        DataColumn(label: Text('Actions')),
      ],
      rows: result?.result
              .map((m) => DataRow(cells: [
                    DataCell(Text(m.id.toString())),
                    DataCell(Text(m.name!)),
                    DataCell(Text(m.resort?.name ?? m.resortId.toString())),
                    DataCell(
                        Text(m.difficulty?.name ?? m.difficultyId!.toString())),
                    DataCell(Text(m.isFunctional! ? "Yes" : "No")),
                    DataCell(Text(m.length!.toString())),
                    DataCell(
                      ElevatedButton(
                        onPressed: () => navigateToEditPage(context, m),
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
