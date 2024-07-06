import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_mobile/components/date_picker_field.dart';
import 'package:skicentar_mobile/components/dropdown_field.dart';
import 'package:skicentar_mobile/components/input_field.dart';
import 'package:skicentar_mobile/models/search_result.dart';
import 'package:skicentar_mobile/models/ticket.dart';
import 'package:skicentar_mobile/models/ticket_type.dart';
import 'package:skicentar_mobile/providers/payment_provider.dart';
import 'package:skicentar_mobile/providers/resort_provider.dart';
import 'package:skicentar_mobile/providers/ticket_provider.dart';
import 'package:skicentar_mobile/providers/ticket_type_provider.dart';
import 'package:skicentar_mobile/providers/user_provider.dart';
import 'package:skicentar_mobile/utils/utils.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  Map<String, dynamic>? paymentIntent;
  late PaymentProvider paymentProvider;
  late TicketTypeProvider ticketTypeProvider;
  late TicketProvider ticketProvider;
  late ResortProvider resortProvider;
  late UserProvider userProvider;

  SearchResult<TicketType>? ticketTypeResult;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    paymentProvider = Provider.of<PaymentProvider>(context, listen: false);
    ticketTypeProvider = context.read<TicketTypeProvider>();
    ticketProvider = context.read<TicketProvider>();
    resortProvider = context.read<ResortProvider>();
    userProvider = context.read<UserProvider>();
    initForm();
    _fetchData();
  }

  Future initForm() async {
    _initialValue = {
      'validFrom': DateTime.now(),
      'ticketTypeId': '',
      'totalPrice': 0,
      'description': '',
      'active': true,
      'name': userProvider.currentUser?.userDetails?.name,
      'lastName': userProvider.currentUser?.userDetails?.lastName,
      'dateOfBirth': userProvider.currentUser?.userDetails?.dateOfBirth
    };
  }

  Future<void> _fetchData() async {
    ticketTypeResult = await ticketTypeProvider
        .get(filter: {'ResortId': resortProvider.selectedResort?.id});
    await initForm();

    if (mounted) {
      setState(() {
        loaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Buy Ticket'),
          backgroundColor: Theme.of(context).primaryColorLight,
        ),
        resizeToAvoidBottomInset: true,
        body: loaded == false
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [_buildForm()],
                ),
              ));
  }

  Widget _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                DropdownField(
                  name: "ticketTypeId",
                  labelText: "Select Ticket",
                  validators: [FormBuilderValidators.required()],
                  items: ticketTypeResult?.result
                          .map((item) => DropdownMenuItem<String>(
                              value: item.id.toString(),
                              child: Text(
                                  "${item.ticketTypeSeniority!.seniority} - ${item.fullDay! ? "Full Day" : "Half a day"} ${item.price}KM")))
                          .toList() ??
                      [],
                ),
                const SizedBox(height: 16),
                DatePickerField(
                  name: "validFrom",
                  labelText: "Date",
                  firstDate: DateTime.now(),
                ),
                const SizedBox(height: 20),
                InputField(
                  name: "name",
                  labelText: "Name",
                  validators: [FormBuilderValidators.required()],
                ),
                const SizedBox(height: 16),
                InputField(
                  name: "lastName",
                  labelText: "Last name",
                  validators: [FormBuilderValidators.required()],
                ),
                const SizedBox(height: 16),
                DatePickerField(
                  name: "dateOfBirth",
                  labelText: "Date of Birth",
                  validators: [FormBuilderValidators.required()],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: _createTicketAndPay,
                        child: const Text('Buy'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TicketType? _getSelectedTicketType(String ticketTypeId) {
    try {
      return ticketTypeResult?.result
          .firstWhere((ticketType) => ticketType.id.toString() == ticketTypeId);
    } catch (e) {
      return null;
    }
  }

  Future<void> _createTicketAndPay() async {
    try {
      if (_formKey.currentState?.saveAndValidate() ?? false) {
        Map<String, dynamic> obj =
            Map<String, dynamic>.from(_formKey.currentState?.value ?? {});

        // Get the selected ticket type
        final selectedTicketType = _getSelectedTicketType(obj['ticketTypeId']);

        if (selectedTicketType == null) {
          throw Exception('Selected ticket type is invalid');
        }

        // Create a ticket
        final ticketCreateRequest = {
          'ticketTypeId': obj['ticketTypeId'],
          'validFrom': formatDateTime(obj['validFrom']),
          'validTo': formatDateTime(obj['validFrom']),
          'description': obj['name'] + obj['lastName'],
          'totalPrice': selectedTicketType.price,
          'active': true,
        };
        final ticket = await ticketProvider.insert(ticketCreateRequest);

        // Create a payment intent
        paymentIntent = await createPaymentIntent(
          (selectedTicketType.price! * 100)
              .toInt(),
          'BAM',
        );

        var gpay = const stripe.PaymentSheetGooglePay(
          merchantCountryCode: "BA",
          currencyCode: "BAM",
          testEnv: true,
        );

        // Initialize the payment sheet
        await stripe.Stripe.instance.initPaymentSheet(
          paymentSheetParameters: stripe.SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!['clientSecret'],
            style: ThemeMode.light,
            merchantDisplayName: 'SKI CENTERS BIH',
            googlePay: gpay,
          ),
        );

        // Display the payment sheet
        await displayPaymentSheet(ticket);
      }
    } catch (err) {
      print("Error: $err");
    }
  }

  Future<void> displayPaymentSheet(Ticket ticket) async {
    try {
      await stripe.Stripe.instance.presentPaymentSheet().then((value) async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Payment successful!')),
        );

        // Save the payment data
        final paymentData = {
          'userId': userProvider.currentUser!.id,
          'ticketId': ticket.id,
          'purchaseDate': DateTime.now().toIso8601String(),
          'quantity': 1,
          'totalPrice': ticket.totalPrice,
          'stripePaymentIntentId': paymentIntent!['clientSecret'],
        };
        await paymentProvider.savePayment(paymentData);

        setState(() {
          paymentIntent = null;
        });
        await _fetchUser();
      });
    } on stripe.StripeException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.error.localizedMessage!)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      int amount, String currency) async {
    try {
      return await paymentProvider.createPaymentIntent(amount, currency);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<void> _fetchUser() async {
    try {
      final fetchedUser = await userProvider.getDetails();
      userProvider.setUser(fetchedUser);
    } catch (e) {
      print('Failed to load user: $e');
    }
  }
}
