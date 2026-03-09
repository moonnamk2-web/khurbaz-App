import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moona/utils/network/network_routes.dart';

import '../../../models/product_model.dart';

class ProductsApi {
  static Future<List<ProductModel>> getProducts({
    int? subCategoryId,
    required int page,
    required bool daily,
    required bool hasDiscount,
  }) async {
    final res = await http.get(
      Uri.parse(
        '$baseUrl/products?'
                'page=$page' +
            (subCategoryId != null ? '&sub_category_id=$subCategoryId' : '') +
            (daily ? '&daily=1' : '') +
            (hasDiscount ? '&has_discount=1' : ''),
      ),
      headers: headersWithToken,
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to load products');
    }

    final body = jsonDecode(res.body);
    final List list = body['data']['data'];

    return list.map((e) => ProductModel.fromJson(e)).toList();
  }

  static Future<ProductModel> getProduct(int id) async {
    final res = await http.get(
      Uri.parse('$baseUrl/products/$id'),
      headers: headersWithToken,
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to load product');
    }

    final json = jsonDecode(res.body);
    return ProductModel.fromJson(json['data']);
  }

  Future<List<ProductModel>> searchProducts({
    required String query,
    required int sortIndex,
    required bool availableOnly,
    required bool discountOnly,
  }) async {
    String sort;

    switch (sortIndex) {
      case 1:
        sort = "cheap";
        break;
      case 2:
        sort = "expensive";
        break;
      default:
        sort = "nearest";
    }

    final uri = Uri.parse("$baseUrl/products/search").replace(
      queryParameters: {
        "q": query,
        "sort": sort,
        "available": availableOnly ? "1" : "0",
        "discount": discountOnly ? "1" : "0",
      },
    );

    final response = await http.get(uri, headers: headersWithToken);

    print('=========searchProducts ${response.body}');
    final data = jsonDecode(response.body);

    return (data['data'] as List).map((e) => ProductModel.fromJson(e)).toList();
  }
}
