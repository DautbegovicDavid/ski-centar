import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_desktop/components/dropdown_field.dart';
import 'package:skicentar_desktop/components/input_field.dart';
import 'package:skicentar_desktop/components/table_wrapper.dart';
import 'package:skicentar_desktop/layouts/master_screen.dart';
import 'package:skicentar_desktop/models/resort.dart';
import 'package:skicentar_desktop/models/search_result.dart';
import 'package:skicentar_desktop/models/ticket_type.dart';
import 'package:skicentar_desktop/models/ticket_type_seniority.dart';
import 'package:skicentar_desktop/providers/resort_provider.dart';
import 'package:skicentar_desktop/providers/ticket_type_provider.dart';
import 'package:skicentar_desktop/providers/ticket_type_seniority_provider.dart';
import 'package:skicentar_desktop/screens/ticket_type_add_screen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:skicentar_desktop/utils/utils.dart';

class TicketTypeListScreen extends StatefulWidget {
  const TicketTypeListScreen({super.key});

  @override
  State<TicketTypeListScreen> createState() => _TicketTypeListScreenState();
}

class _TicketTypeListScreenState extends State<TicketTypeListScreen> {
  late TicketTypeProvider provider;
  late TicketTypeSeniorityProvider ticketTypeSeniorityProvider;
  late ResortProvider resortProvider;
  SearchResult<TicketType>? result;
  List<TicketTypeSeniority> _ticketTypeSeniorities = [];
  List<Resort> _resorts = [];

  final _formKey = GlobalKey<FormBuilderState>();
  var filter = {};
  final Map<String, dynamic> _initialValue = {};

  final Map<String, bool> _selectedColumns = {
    'Resort': true,
    'Price': true,
    'Seniority': true,
    'Full day': true,
  };

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Tickets",
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
      true,
    );
  }

  @override
  void initState() {
    provider = context.read<TicketTypeProvider>();
    ticketTypeSeniorityProvider = context.read<TicketTypeSeniorityProvider>();
    resortProvider = context.read<ResortProvider>();
    super.initState();
    provider.addListener(_fetchData);
    _fetchData();
  }

  Future<void> _fetchData() async {
    result = await provider.get(filter: filter);
    var seniorities = await ticketTypeSeniorityProvider.get(filter: {});
    var resorts = await resortProvider.get(filter: {});
    _ticketTypeSeniorities = seniorities.result;
    _resorts = resorts.result;
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
              DropdownField(
                name: "resortId",
                labelText: "Resort",
                items: _resorts
                    .map((item) => DropdownMenuItem<String>(
                        value: item.id.toString(),
                        child: Text(item.name ?? "")))
                    .toList(),
              ),
              const SizedBox(width: 12),
              DropdownField(
                name: "TicketTypeSeniorityId",
                labelText: "Seniority",
                items: _ticketTypeSeniorities
                    .map((item) => DropdownMenuItem<String>(
                        value: item.id.toString(),
                        child: Text(item.seniority ?? "")))
                    .toList(),
              ),
              const SizedBox(width: 12),
              InputField(
                name: "PriceFrom",
                labelText: "Price from",
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(width: 12),
              InputField(
                name: "PriceTo",
                labelText: "Price to",
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const Spacer(),
              if (isFormDirty(_formKey, [
                'TicketTypeSeniorityId',
                'resortId',
                'PriceFrom',
                'PriceTo',
              ]))
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () async {
                    resetForm(
                      _formKey,
                      {
                        'resortId': null,
                        'TicketTypeSeniorityId': null,
                        'PriceFrom': null,
                        'PriceTo': null,
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

  Future<void> _generatePdfReport() async {
    final pdf = pw.Document();

    final selectedHeaders = _selectedColumns.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    final selectedData = result?.result.map((m) {
          final data = [];
          if (_selectedColumns['Resort'] ?? false) {
            data.add(m.resort?.name ?? '');
          }
          if (_selectedColumns['Price'] ?? false) {
            data.add(m.price.toString());
          }
          if (_selectedColumns['Seniority'] ?? false) {
            data.add(m.ticketTypeSeniority?.seniority ?? '');
          }
          if (_selectedColumns['Full day'] ?? false) {
            data.add(m.fullDay! ? "Yes" : "No");
          }
          return data;
        }).toList() ??
        [];

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Tickets Report',
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

  Widget _buildResultView() {
    return TableWrapper(
      columns: const [
        DataColumn(label: Text("Resort")),
        DataColumn(label: Text("Price")),
        DataColumn(label: Text("Seniority")),
        DataColumn(label: Text("Full day")),
        DataColumn(label: Text("Actions")),
      ],
      rows: result?.result
              .map((m) => DataRow(cells: [
                    DataCell(Text(m.resort?.name ?? "")),
                    DataCell(Text(m.price.toString())),
                    DataCell(Text(m.ticketTypeSeniority?.seniority ?? "")),
                    DataCell(Text(m.fullDay! ? "Yes" : "No")),
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

  void navigateToEditPage(BuildContext context, TicketType ticketType) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TicketTypeAddScreen(ticketType: ticketType)),
    );
  }

  Future<void> _search() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      var formValues =
          Map<String, dynamic>.from(_formKey.currentState?.value ?? {});
      result = await provider.get(filter: formValues);
      setState(() {});
    }
  }
}
