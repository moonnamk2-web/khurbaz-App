import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/product_model.dart';
import '../../../utils/network/network_routes.dart';

class CartResponse {
  final List<ProductModel> items;
  final int currentPage;
  final int lastPage;
  final int total;

  CartResponse({
    required this.items,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });
}

class CartSummury {
  final int totalItems;
  final double productsTotal;
  final double deliveryFee;
  final double discountTotal;
  final double grandTotal;

  CartSummury({
    required this.totalItems,
    required this.productsTotal,
    required this.deliveryFee,
    required this.discountTotal,
    required this.grandTotal,
  });

  factory CartSummury.fromJson(Map<String, dynamic> json) {
    return CartSummury(
      totalItems: json['total_items'] ?? 0,
      productsTotal: double.parse((json['products_total'] ?? 0).toString()),
      deliveryFee: double.parse((json['delivery_fee'] ?? 0).toString()),
      discountTotal: double.parse((json['discount_total'] ?? 0).toString()),
      grandTotal: double.parse((json['grand_total'] ?? 0).toString()),
    );
  }
}

class CartApi {
  static Future<CartSummury> summary() async {
    final response = await http.get(
      Uri.parse('$baseUrl/cart/summary'),
      headers: headersWithToken,
    );

    print('==========summary: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to load cart summary');
    }

    final body = jsonDecode(response.body);
    final data = body['data'];

    return CartSummury.fromJson(data);
  }

  static Future<CartResponse> getCart({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/cart?page=$page'),
      headers: headersWithToken,
    );
    print('==========getCart: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to load cart');
    }

    final body = jsonDecode(response.body);
    final data = body['data'];

    return CartResponse(
      items: (data['data'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList(),
      currentPage: data['current_page'],
      lastPage: data['last_page'],
      total: data['total'],
    );
  }

  /// ADD (or increase)
  static Future<int> add({
    required int productId,
    required int quantity,
  }) async {
    final res = await http.post(
      Uri.parse('$baseUrl/cart/add'),
      headers: headersWithToken,
      body: jsonEncode({'product_id': productId, 'quantity': quantity}),
    );
    print('==========add: ${res.body}');
    final body = jsonDecode(res.body);
    final data = body['data'];
    return data['id'];
  }

  /// UPDATE quantity
  static Future<int?> update({
    required int cartItemId,
    required int quantity,
  }) async {
    final res = await http.put(
      Uri.parse('$baseUrl/cart/$cartItemId'),
      headers: headersWithToken,
      body: jsonEncode({'quantity': quantity}),
    );
    print('==========update: ${res.body}');
    final body = jsonDecode(res.body);
    return body['available_quantity'];
  }

  /// REMOVE
  static Future<void> remove(int cartItemId) async {
    await http.delete(
      Uri.parse('$baseUrl/cart/$cartItemId'),
      headers: headersWithToken,
    );
  }
}
