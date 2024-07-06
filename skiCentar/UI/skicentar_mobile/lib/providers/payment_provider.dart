import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skicentar_mobile/providers/base_provider.dart';
import 'package:skicentar_mobile/utils/api_helper.dart';
import 'package:skicentar_mobile/utils/auth_helper.dart';

class PaymentProvider with ChangeNotifier {

  Future<Map<String, dynamic>> createPaymentIntent(
      int amount, String currency) async {

    var url =
        Uri.parse("${BaseProvider.baseUrl}payments/create-payment-intent");
    String token = await AuthHelper.getToken();

    final response = await http.post(
      url,
      headers: ApiHelper.createHeaders(token),
      body: json.encode({'amount': amount, 'currency': currency}),
    );
    return json.decode(response.body);
  }

  Future<void> savePayment(Map<String, dynamic> paymentData) async {
    final url = Uri.parse("${BaseProvider.baseUrl}payments/save-payment");
    String token = await AuthHelper.getToken();
    final response = await http.post(
      url,
      headers: ApiHelper.createHeaders(token),
      body: json.encode(paymentData),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to save payment data');
    }
  }
}
