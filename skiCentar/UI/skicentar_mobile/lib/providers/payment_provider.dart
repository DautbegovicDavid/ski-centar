import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:skicentar_mobile/providers/base_provider.dart';
import 'package:skicentar_mobile/utils/auth_helper.dart';
import 'package:http/http.dart' as http;

class PaymentProvider with ChangeNotifier {
  Future<Map<String, dynamic>> createPaymentIntent(
      int amount, String currency) async {
    var url =
        Uri.parse("${BaseProvider.baseUrl}payments/create-payment-intent");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'amount': amount, 'currency': currency}),
    );
    return json.decode(response.body);
  }

  Future<void> savePayment(Map<String, dynamic> paymentData) async {
    final url = Uri.parse("${BaseProvider.baseUrl}payments/save-payment");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(paymentData),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to save payment data');
    }
  }

  Future<Response> _geta(String url) async {
    String token = await AuthHelper.getToken();
    var uri = Uri.parse(url);
    var headers = createHeaders(token);

    var response = await http.get(uri, headers: headers);

    if (!AuthHelper.isValidResponse(response)) {
      throw Exception("Unknown error");
    }
    return response;
  }

  createHeaders(String token) {}
}
