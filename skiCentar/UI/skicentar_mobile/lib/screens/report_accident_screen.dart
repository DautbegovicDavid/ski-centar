import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_mobile/components/input_field.dart';
import 'package:skicentar_mobile/components/toggle_field.dart';
import 'package:skicentar_mobile/providers/ski_accident_provider.dart';
import 'package:skicentar_mobile/providers/user_provider.dart';
import 'package:skicentar_mobile/utils/utils.dart';

class ReportAccidentScreen extends StatefulWidget {
  @override
  State<ReportAccidentScreen> createState() => _ReportAccidentScreenState();
}

class _ReportAccidentScreenState extends State<ReportAccidentScreen> {
  late UserProvider userProvider;
  late SkiAccidentProvider skiAccidentProvider;
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  LocationData? _locationData;
  bool _isLoading = false;

  @override
  void initState() {
    userProvider = context.read<UserProvider>();
    skiAccidentProvider = context.read<SkiAccidentProvider>();
    super.initState();
    initForm();
    _getLocation();
  }

  Future<void> initForm() async {
    setState(() {
      _initialValue = {
        'peopleInvolved': '',
        'isReporterInjured': false,
      };
    });
  }

  Future<void> _getLocation() async {
    setState(() {
      _isLoading = true;
    });

    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        showCustomSnackBar(context, Icons.error, Colors.red,
            'Location services are disabled.');
        setState(() {
          _isLoading = false;
        });
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        showCustomSnackBar(context, Icons.error, Colors.red,
            'Location permissions are denied.');
        setState(() {
          _isLoading = false;
        });
        return;
      }
    }

    try {
      _locationData = await location.getLocation();
      if (_locationData != null) {
        setState(() {
          _initialValue['locationX'] = _locationData!.latitude;
          _initialValue['locationY'] = _locationData!.longitude;
        });
      }
    } catch (e) {
      showCustomSnackBar(context, Icons.error, Colors.red,
          'Failed to get location. Please try again.');
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _save() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      var formValues =
          Map<String, dynamic>.from(_formKey.currentState?.value ?? {});
      formValues.removeWhere((key, value) => value == '');
      formValues['timestamp'] = DateTime.now().toIso8601String();

      if (_locationData != null) {
        formValues['locationX'] = _locationData!.latitude;
        formValues['locationY'] = _locationData!.longitude;
      } else {
        showCustomSnackBar(context, Icons.error, Colors.red,
            'Location not available. Please try again.');
        return;
      }

      try {
        formValues['userId'] = userProvider.currentUser!.id;
        await skiAccidentProvider.insert(formValues);
        if (!context.mounted) return;
        showCustomSnackBar(
            context, Icons.check, Colors.green, 'Accident reported.');
      } catch (e) {
        showCustomSnackBar(context, Icons.error, Colors.red,
            'Failed to report accident. Please try again.');
      }
    }
  }

  Widget _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            surfaceTintColor: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  InputField(
                    name: "peopleInvolved",
                    labelText: "People involved",
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3)
                    ],
                  ),
                  const SizedBox(height: 16),
                  const ToggleField(
                    name: "isReporterInjured",
                    title: "Are you injured",
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: _save,
                          child: const Text('Report Accident'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Report Accident'),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        body: userProvider.currentUser == null || _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [_buildForm()],
                ),
              ));
  }
}
