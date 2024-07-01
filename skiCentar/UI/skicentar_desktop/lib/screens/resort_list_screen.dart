import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_desktop/components/input_field.dart';
import 'package:skicentar_desktop/components/table_wrapper.dart';
import 'package:skicentar_desktop/layouts/master_screen.dart';
import 'package:skicentar_desktop/models/resort.dart';
import 'package:skicentar_desktop/models/search_result.dart';
import 'package:skicentar_desktop/providers/resort_provider.dart';
import 'package:skicentar_desktop/screens/resort_add_screen.dart';

class ResortListScreen extends StatefulWidget {
  const ResortListScreen({super.key});

  @override
  State<ResortListScreen> createState() => _ResortListScreenState();
}

class _ResortListScreenState extends State<ResortListScreen> {
  late ResortProvider provider;
  SearchResult<Resort>? result;

  final _formKey = GlobalKey<FormBuilderState>();
  var filter = {'NameGTE': null, 'elevationFrom': null, 'elevationTo': null};
  final Map<String, dynamic> _initialValue = {};

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Resorts",
        Column(
          children: [_buildSearch(), _buildResultView()],
        ),
        false,
        true);
  }

  @override
  void initState() {
    provider = context.read<ResortProvider>();
    super.initState();
    provider.addListener(_fetchData);
    _fetchData();
  }

  Future<void> _fetchData() async {
    result = await provider.get(filter: null);
    setState(() {});
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
              InputField(
                name: "elevationFrom",
                labelText: "Elevation from",
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(width: 12),
              InputField(
                name: "elevationTo",
                labelText: "Elevation to",
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
      result = await provider.get(filter: formValues);
      setState(() {});
    }
  }

  void navigateToEditPage(BuildContext context, Resort resort) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResortAddScreen(resort: resort)),
    );
  }

  Widget _buildResultView() {
    return TableWrapper(
      columns: const [
        DataColumn(label: Text("Id"), numeric: true),
        DataColumn(label: Text("Name")),
        DataColumn(label: Text("Location - City")),
        DataColumn(label: Text("Elevation (m)")),
        DataColumn(label: Text("SKI work hours")),
        DataColumn(label: Text("Actions")),
      ],
      rows: result?.result
              .map((m) => DataRow(cells: [
                    DataCell(Text(m.id.toString())),
                    DataCell(Text(m.name!)),
                    DataCell(Text(m.location!)),
                    DataCell(Text(m.elevation!.toString())),
                    DataCell(Text(m.skiWorkHours!)),
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
