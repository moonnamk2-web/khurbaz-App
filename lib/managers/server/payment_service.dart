import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/network/network_routes.dart';

class PaymentService {
  Future<Map<String, dynamic>> startCheckout({required int addressId}) async {
    final url = Uri.parse('$baseUrl/payment/start-checkout');

    final body = jsonEncode({'address_id': addressId});

    final response = await http.post(
      url,
      headers: headersWithToken,
      body: body,
    );
    print('==========startCheckout ${response.body}');

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': true,
        'checkout_url': data['checkout_url'],
        'payment_id': data['payment_id'],
      };
    } else {
      return {
        'success': false,
        'message': data['message'] ?? 'Checkout failed',
      };
    }
  }

  /*
  |--------------------------------------------------------------------------
  | 2️⃣ التحقق من الدفع بعد الرجوع من WebView
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> verifyPayment({
    required int paymentLocalId,
    required String paymentMoyasarId,
  }) async {
    final url = Uri.parse(
      '$baseUrl/payment/verify/$paymentLocalId?id=$paymentMoyasarId',
    );

    final response = await http.get(url, headers: headersWithToken);

    print('==========verifyPayment ${response.body}');

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['status'] == true) {
      return {'success': true, 'order_id': data['order_id']};
    }

    return {
      'success': false,
      'message': data['message'] ?? 'Payment not completed',
    };
  }
}
