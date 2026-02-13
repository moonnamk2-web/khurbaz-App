import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/order/order.dart';
import '../../../models/order/order_details.dart';
import '../../../utils/network/network_routes.dart';

class OrdersApi {
  static Future<Map<String, dynamic>> getOrders(int page) async {
    final res = await http.get(
      Uri.parse('$baseUrl/orders?page=$page'),
      headers: headersWithToken,
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to load orders');
    }

    final body = jsonDecode(res.body);

    return {
      'orders': (body['data']['data'] as List)
          .map((e) => OrderModel.fromJson(e))
          .toList(),
      'hasMore': body['data']['next_page_url'] != null,
    };
  }

  static Future<OrderDetailsModel> getOrderDetails(int id) async {
    final res = await http.get(
      Uri.parse('$baseUrl/order/$id'),
      headers: headersWithToken,
    );
    print('=======getOrderDetails ${res.body}');

    if (res.statusCode != 200) {
      throw Exception('Failed to load order');
    }

    final body = jsonDecode(res.body);
    return OrderDetailsModel.fromJson(body['data']);
  }
}
