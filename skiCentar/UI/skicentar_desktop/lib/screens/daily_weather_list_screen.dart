import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_desktop/components/date_picker_field.dart';
import 'package:skicentar_desktop/components/dropdown_field.dart';
import 'package:skicentar_desktop/components/input_field.dart';
import 'package:skicentar_desktop/components/table_wrapper.dart';
import 'package:skicentar_desktop/layouts/master_screen.dart';
import 'package:skicentar_desktop/models/daily_weather.dart';
import 'package:skicentar_desktop/models/resort.dart';
import 'package:skicentar_desktop/models/search_result.dart';
import 'package:skicentar_desktop/providers/daily_weather_provider.dart';
import 'package:skicentar_desktop/providers/resort_provider.dart';
import 'package:skicentar_desktop/screens/daily_weather_add_screen.dart';

class DailyWeatherListScreen extends StatefulWidget {
  const DailyWeatherListScreen({super.key});

  @override
  State<DailyWeatherListScreen> createState() => _DailyWeatherListScreenState();
}

class _DailyWeatherListScreenState extends State<DailyWeatherListScreen> {
  late DailyWeatherProvider provider;
  late ResortProvider resortProvider;

  SearchResult<DailyWeather>? result;
  List<Resort> _resorts = [];

  final DateFormat formatter = DateFormat('dd MMM yyyy');

  final _formKey = GlobalKey<FormBuilderState>();
  var filter = {'NameGTE': null, 'elevationFrom': null, 'elevationTo': null};
  final Map<String, dynamic> _initialValue = {};

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Weather conditions",
        Column(
          children: [_buildSearch(), _buildResultView()],
        ),
        false,
        true);
  }

  @override
  void initState() {
    provider = context.read<DailyWeatherProvider>();
    resortProvider = context.read<ResortProvider>();
    super.initState();
    provider.addListener(_onProviderChange);
    _fetchData();
  }

  void _onProviderChange() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    result = await provider.get(filter: null);
    var resorts = await resortProvider.get(filter: null);
    if (mounted) {
      setState(() {
        _resorts = resorts.result;
      });
    }
  }

  Widget _buildSearch() {
    return Card(
      margin: const EdgeInsets.all(10.0),
      elevation: 2.0,
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
              const SizedBox(width: 10),
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
              const SizedBox(width: 10),
              InputField(
                name: "TemperatureFrom",
                labelText: "Temperature from",
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(width: 10),
              InputField(
                name: "TemperatureTo",
                labelText: "Temperature to",
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
              ElevatedButton(
                onPressed: _search,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
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

  void navigateToEditPage(BuildContext context, DailyWeather dailyWeather) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              DailyWeatherAddScreen(dailyWeather: dailyWeather)),
    );
  }

  Widget _buildResultView() {
    return TableWrapper(
      columns: const [
        DataColumn(label: Text("Id"), numeric: true),
        DataColumn(label: Text("Date")),
        DataColumn(label: Text("Temperature")),
        DataColumn(label: Text("Snow Height")),
        DataColumn(label: Text("Precipitation")),
        DataColumn(label: Text("Weather Condition")),
        DataColumn(label: Text("Actions")),
      ],
      rows: result?.result
              .map((m) => DataRow(cells: [
                    DataCell(Text(m.id.toString())),
                    DataCell(Text(formatter.format(m.date!))),
                    DataCell(Text(
                        m.temperature != null ? '${m.temperature} °C' : '')),
                    DataCell(
                        Text(m.snowHeight != null ? '${m.snowHeight} cm' : '')),
                    DataCell(Text(m.precipitation != null
                        ? '${m.precipitation} mm'
                        : '')),
                    DataCell(Text(m.weatherCondition ?? '')),
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
