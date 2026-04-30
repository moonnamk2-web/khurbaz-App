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
    required DateTime? executionTime,
  }) async {
    try {
      final url = Uri.parse(
        '$baseUrl/payment/verify/$paymentLocalId?id=$paymentMoyasarId'
        '${executionTime != null ? '&execution_time=${executionTime.toIso8601String()}' : ""}',
      );

      print('🔵 URL: $url');

      final response = await http.get(url, headers: headersWithToken);

      print('🟢 Status Code: ${response.statusCode}');
      print('🟢 Response: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        return {'success': true, 'order_id': data['order_id']};
      }

      return {
        'success': false,
        'message': data['message'] ?? 'Payment not completed',
      };
    } catch (e, stackTrace) {
      print('🔴 ERROR: $e');
      print('🔴 STACK: $stackTrace');

      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> checkout({
    required String addressId,
    required String moyasarId,
    required String paymentMethod,
    required DateTime? executionTime,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/payment/checkout');

      final body = jsonEncode({
        'address_id': addressId,
        'moyasar_id': moyasarId,
        'payment_method': paymentMethod,
        if (executionTime != null)
          'execution_time': executionTime.toIso8601String(),
      });

      final response = await http.post(
        url,
        headers: headersWithToken,
        body: body,
      );
      print('==========checkout ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'order_id': data['order_id'],
          // 'payment_id': data['payment_id'],
        };
      } else {
        return {'success': false, 'message': data['message']};
      }
    } catch (e, stackTrace) {
      print('🔴 ERROR: $e');
      print('🔴 STACK: $stackTrace');

      return {'success': false, 'message': e.toString()};
    }
  }
}
