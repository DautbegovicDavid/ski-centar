import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_desktop/components/date_picker_field.dart';
import 'package:skicentar_desktop/components/form_wrapper.dart';
import 'package:skicentar_desktop/components/input_field.dart';
import 'package:skicentar_desktop/layouts/master_screen.dart';
import 'package:skicentar_desktop/models/daily_weather.dart';
import 'package:skicentar_desktop/models/resort.dart';
import 'package:skicentar_desktop/models/search_result.dart';
import 'package:skicentar_desktop/providers/daily_weather_provider.dart';
import 'package:skicentar_desktop/providers/resort_provider.dart';
import 'package:skicentar_desktop/utils/utils.dart';
import '../components/dropdown_field.dart';

class DailyWeatherAddScreen extends StatefulWidget {
  final DailyWeather? dailyWeather;
  const DailyWeatherAddScreen({super.key, this.dailyWeather});
  @override
  State<DailyWeatherAddScreen> createState() => _DailyWeatherAddScreenState();
}

class _DailyWeatherAddScreenState extends State<DailyWeatherAddScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late ResortProvider resortProvider;
  late DailyWeatherProvider provider;
  SearchResult<Resort>? resortsResult;

  @override
  void initState() {
    provider = context.read<DailyWeatherProvider>();
    resortProvider = context.read<ResortProvider>();
    super.initState();
    initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    _initialValue = {
      'date': widget.dailyWeather?.date ?? DateTime.now(),
      'temperature': widget.dailyWeather?.temperature?.toString() ?? '',
      'precipitation': widget.dailyWeather?.precipitation?.toString() ?? '',
      'resortId': widget.dailyWeather?.resortId?.toString() ?? '',
      'windSpeed': widget.dailyWeather?.windSpeed?.toString() ?? '',
      'humidity': widget.dailyWeather?.humidity?.toString() ?? '',
      'weatherCondition':
          widget.dailyWeather?.weatherCondition.toString() ?? '',
      'snowHeight': widget.dailyWeather?.snowHeight.toString(),
    };
    resortsResult = await resortProvider.get();
    setState(() {});
  }

  Future _save() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      var formValues =
          Map<String, dynamic>.from(_formKey.currentState?.value ?? {});

      formValues.removeWhere((key, value) => value == '');
      formValues['date'] = formatDateTime(formValues['date']);
      try {
        if (widget.dailyWeather == null) {
          await provider.insert(formValues);
        } else {
          await provider.update(widget.dailyWeather!.id!, formValues);
        }
        if (!context.mounted) return;
        showCustomSnackBar(context, Icons.check, Colors.green,
            'Weather conditions saved successfully!');
        Navigator.pop(context);
      } catch (e) {
        showCustomSnackBar(context, Icons.error, Colors.red,
            'Failed to save weather conditions. Please try again.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        widget.dailyWeather == null
            ? "Add new weather condtions"
            : "Edit weather conditons",
        Column(children: [
          FormWrapper(children: [_buildForm(), _saveRow()]),
        ]),
        true,
        false);
  }

  Widget _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputField(
                name: "temperature",
                labelText: "Temperature",
                suffixText: '°C',
                keyboardType: TextInputType.number,
                validators: [FormBuilderValidators.required()],
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d{0,2}(.\d{0,2})?$')),
                      LengthLimitingTextInputFormatter(3)
                ],
              ),
              const SizedBox(width: 10),
              InputField(
                name: "precipitation",
                labelText: "Precipitation",
                suffixText: 'mm',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d{0,2}(,\d{0,2})?$'))
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownField(
                name: "resortId",
                labelText: "Resort",
                validators: [FormBuilderValidators.required()],
                items: resortsResult?.result
                        .map((item) => DropdownMenuItem(
                            value: item.id.toString(),
                            child: Text(item.name ?? "")))
                        .toList() ??
                    [],
              ),
              const SizedBox(width: 10),
              InputField(
                name: "windSpeed",
                labelText: "Wind Speed",
                suffixText: 'km/h',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3)
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputField(
                name: "humidity",
                labelText: "Humidity",
                suffixText: '%',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2)
                ],
              ),
              const SizedBox(width: 10),
              InputField(
                name: "snowHeight",
                labelText: "Snow Height",
                suffixText: 'cm',
                validators: [FormBuilderValidators.required()],
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3)
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DatePickerField(
                name: "date",
                labelText: "Date time",
                dateFormat: 'MM/dd/yyyy hh:mm',
                enabled: false,
              ),
              const SizedBox(width: 10),
              InputField(
                name: "weatherCondition",
                labelText: "Brief description",
                validators: [FormBuilderValidators.required()],
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _saveRow() {
    return Row(
      children: [
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FilledButton(
              onPressed: _save,
              child: const Text("Save")),
        ),
      ],
    );
  }
}
