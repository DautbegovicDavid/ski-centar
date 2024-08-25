import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_desktop/components/date_picker_field.dart';
import 'package:skicentar_desktop/components/input_field.dart';
import 'package:skicentar_desktop/components/table_wrapper.dart';
import 'package:skicentar_desktop/layouts/master_screen.dart';
import 'package:skicentar_desktop/models/search_result.dart';
import 'package:skicentar_desktop/models/ski_accident.dart';
import 'package:skicentar_desktop/providers/ski_accident_provider.dart';
import 'package:skicentar_desktop/providers/trail_provider.dart';
import 'package:skicentar_desktop/providers/user_provider.dart';
import 'package:skicentar_desktop/screens/accidents_add_screen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class AccidentsListScreen extends StatefulWidget {
  const AccidentsListScreen({super.key});

  @override
  State<AccidentsListScreen> createState() => _AccidentsListScreenState();
}

class _AccidentsListScreenState extends State<AccidentsListScreen> {
  late SkiAccidentProvider provider;
  late UserProvider userProvider;
  late TrailProvider trailProvider;

  SearchResult<SkiAccident>? result;

  final _formKey = GlobalKey<FormBuilderState>();
  var filter = {};
  final Map<String, dynamic> _initialValue = {};

  final DateFormat formatter = DateFormat('dd MMM yyyy HH:mm');

  final Map<String, bool> _selectedColumns = {
    'Id': true,
    'Date': true,
    'Active': true,
    'People involved': true,
    'Reported by': true,
    'Reporter injured': true,
  };

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Accidents",
      Column(
        children: [
          _buildSearch(),
           if (result != null && result!.result.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Spacer(),
                const Text("GENERATE REPORT"),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: _showColumnSelectionDialog,
                ),
                IconButton(
                  icon: const Icon(Icons.picture_as_pdf),
                  onPressed: _generatePdfReport,
                ),
              ],
            ),
          ),
          _buildResultView(),
        ],
      ),
      false,
      false,
    );
  }

  @override
  void initState() {
    provider = context.read<SkiAccidentProvider>();
    super.initState();
    provider.addListener(_fetchData);
    _fetchData();
  }

  Future<void> _fetchData() async {
    result = await provider.get(filter: null);
    if (mounted) {
      setState(() {});
    }
  }

  void _showColumnSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Columns'),
          content: SingleChildScrollView(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  children: _selectedColumns.keys.map((String key) {
                    return CheckboxListTile(
                      title: Text(key),
                      value: _selectedColumns[key],
                      onChanged: (bool? value) {
                        setState(() {
                          _selectedColumns[key] = value ?? false;
                        });
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
              const DatePickerField(
                name: "DateFrom",
                initialValue: null,
                labelText: "Date from",
              ),
              const SizedBox(width: 10),
              const DatePickerField(
                name: "DateTo",
                initialValue: null,
                labelText: "Date to",
              ),
              const SizedBox(width: 12),
              InputField(
                name: "PeopleInvolvedFrom",
                labelText: "People involved from",
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(width: 12),
              InputField(
                name: "PeopleInvolvedTo",
                labelText: "People involved to",
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
      print(result);
      setState(() {});
    }
  }

  void navigateToEditPage(BuildContext context, SkiAccident accident) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AccidentsAddScreen(accident: accident)),
    );
  }

  Widget _buildResultView() {
    return TableWrapper(
      columns: const [
        DataColumn(label: Text("Id"), numeric: true),
        DataColumn(label: Text("Date")),
        DataColumn(label: Text("Active")),
        DataColumn(label: Text("People involved")),
        DataColumn(label: Text("Reported by")),
        DataColumn(label: Text("Reporter injured")),
        DataColumn(label: Text("Actions")),
      ],
      rows: result?.result
              .map((m) => DataRow(cells: [
                    DataCell(Text(m.id.toString())),
                    DataCell(Text(m.timestamp != null
                        ? formatter.format(m.timestamp!)
                        : 'No data')),
                    DataCell(Text(m.isActive! ? "Yes" : "No")),
                    DataCell(Text(m.peopleInvolved?.toString() ?? 'No data')),
                    DataCell(Text(m.user?.userDetails != null &&
                            m.user?.userDetails?.name != null &&
                            m.user?.userDetails?.lastName != null
                        ? '${m.user?.userDetails!.name} ${m.user?.userDetails!.lastName}'
                        : m.user?.email ?? 'No email')),
                    DataCell(Text(m.isReporterInjured! ? "Yes" : "No")),
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

  Future<void> _generatePdfReport() async {
    final pdf = pw.Document();

    final image = await imageFromAssetBundle('assets/images/logo.png');

    final selectedHeaders = _selectedColumns.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    final selectedData = result?.result.map((m) {
          final data = [];
          if (_selectedColumns['Id'] ?? false) data.add(m.id.toString());
          if (_selectedColumns['Date'] ?? false) {
            data.add(m.timestamp != null
                ? formatter.format(m.timestamp!)
                : 'No data');
          }
          if (_selectedColumns['Active'] ?? false) {
            data.add(m.isActive! ? "Yes" : "No");
          }
          if (_selectedColumns['People involved'] ?? false) {
            data.add(m.peopleInvolved?.toString() ?? 'No data');
          }
          if (_selectedColumns['Reported by'] ?? false) {
            data.add(m.user?.userDetails != null &&
                    m.user?.userDetails?.name != null &&
                    m.user?.userDetails?.lastName != null
                ? '${m.user?.userDetails!.name} ${m.user?.userDetails!.lastName}'
                : m.user?.email ?? 'No email');
          }
          if (_selectedColumns['Reporter injured'] ?? false) {
            data.add(m.isReporterInjured! ? "Yes" : "No");
          }
          return data;
        }).toList() ??
        [];

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Image(image, width: 100, height: 100), // Add the image here
              pw.SizedBox(height: 20),
              pw.Text('Accidents Report',
                  style: const pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: selectedHeaders,
                data: selectedData,
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
