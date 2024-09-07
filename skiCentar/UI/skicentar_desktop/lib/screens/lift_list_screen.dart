import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_desktop/components/dropdown_field.dart';
import 'package:skicentar_desktop/components/input_field.dart';
import 'package:skicentar_desktop/components/table_wrapper.dart';
import 'package:skicentar_desktop/layouts/master_screen.dart';
import 'package:skicentar_desktop/models/lift-type.dart';
import 'package:skicentar_desktop/models/lift.dart';
import 'package:skicentar_desktop/models/resort.dart';
import 'package:skicentar_desktop/models/search_result.dart';
import 'package:skicentar_desktop/providers/lift_provider.dart';
import 'package:skicentar_desktop/providers/lift_type_provider.dart';
import 'package:skicentar_desktop/providers/resort_provider.dart';
import 'package:skicentar_desktop/screens/lift_add_screen.dart';
import 'package:skicentar_desktop/utils/utils.dart';

class LiftListScreen extends StatefulWidget {
  const LiftListScreen({super.key});
  @override
  State<LiftListScreen> createState() => _LiftListScreenState();
}

class _LiftListScreenState extends State<LiftListScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final Map<String, dynamic> _initialValue = {};

  SearchResult<Lift>? result;
  List<Resort> _resorts = [];
  List<LiftType> _liftTypes = [];

  late LiftProvider provider;
  late ResortProvider resortProvider;
  late LiftTypeProvider liftTypeProvider;

  var filter = {
    'IsResortIncluded': true,
    'IsLiftTypeIncluded': true,
    'AreLiftLocationsIncluded': true,
  };

  @override
  void initState() {
    provider = context.read<LiftProvider>();
    resortProvider = context.read<ResortProvider>();
    liftTypeProvider = context.read<LiftTypeProvider>();
    super.initState();
    provider.addListener(_fetchData);
    _fetchData();
  }

  Future _fetchData() async {
    result = await provider.get(filter: filter);
    var resorts = await resortProvider.get(filter: {});
    _resorts = resorts.result;
    var liftTypes = await liftTypeProvider.get(filter: {});
    _liftTypes = liftTypes.result;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Lifts",
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
                name: "LiftTypeId",
                labelText: "Lift type",
                items: _liftTypes
                    .map((item) => DropdownMenuItem<String>(
                        value: item.id.toString(),
                        child: Text(item.name ?? "")))
                    .toList(),
              ),
              const SizedBox(width: 12),
              DropdownField(
                name: "ResortId",
                labelText: "Resort",
                items: _resorts
                    .map((item) => DropdownMenuItem<String>(
                        value: item.id.toString(),
                        child: Text(item.name ?? "")))
                    .toList(),
              ),
              const Spacer(),
              if (isFormDirty(_formKey, ['LiftTypeId', 'ResortId', 'NameGTE']))
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () async {
                    resetForm(
                      _formKey,
                      {
                        'LiftTypeId': null,
                        'ResortId': null,
                        'NameGTE': '',
                      },
                    );
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

  void _navigateToEditPage(BuildContext context, Lift lift) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LiftAddScreen(lift: lift)),
    );
  }

  Widget _buildResultView() {
    return TableWrapper(
      columns: const [
        DataColumn(label: Text("Id"), numeric: true),
        DataColumn(label: Text("Name")),
        DataColumn(label: Text("Resort")),
        DataColumn(label: Text("Lift Type")),
        DataColumn(label: Text("Functional")),
        DataColumn(label: Text('Actions')),
      ],
      rows: result?.result
              .map((m) => DataRow(cells: [
                    DataCell(Text(m.id.toString())),
                    DataCell(Text(m.name!)),
                    DataCell(Text(m.resort?.name ?? m.resortId.toString())),
                    DataCell(
                        Text(m.liftType?.name ?? m.liftTypeId!.toString())),
                    DataCell(Text(m.isFunctional! ? "Yes" : "No")),
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
