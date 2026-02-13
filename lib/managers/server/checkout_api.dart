import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/network/network_routes.dart'; // headersWithToken

class CheckoutApi {
  static Future<int> checkout({
    required int addressId,
    required String paymentMethod,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/checkout'),
      headers: headersWithToken,
      body: jsonEncode({
        'address_id': addressId,
        'payment_method': paymentMethod,
      }),
    );

    print('==========checkout: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Checkout failed');
    }

    final body = jsonDecode(response.body);

    if (body['status'] != true) {
      throw Exception(body['message'] ?? 'Checkout error');
    }

    return body['order_id'];
  }
}
