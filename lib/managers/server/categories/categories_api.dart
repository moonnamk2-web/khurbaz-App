import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moona/utils/network/network_routes.dart';

import '../../../models/category_model.dart';
import '../../../models/sub_category_model.dart';

class CategoriesApi {
  static Future<List<CategoryModel>> getCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/categories'),
      headers: headers,
    );
    print('==========categories: ${response.statusCode}');
    print('==========categories: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to load categories');
    }

    final decoded = jsonDecode(response.body);
    final List list = decoded['data'];

    return list.map((e) => CategoryModel.fromJson(e)).toList();
  }

  static Future<List<SubCategoryModel>> getSubCategories(int categoryId) async {
    final res = await http.get(
      Uri.parse('$baseUrl/categories/$categoryId/sub-categories'),
      headers: {'Accept': 'application/json'},
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to load sub categories');
    }

    final list = jsonDecode(res.body)['data'] as List;
    return list.map((e) => SubCategoryModel.fromJson(e)).toList();
  }
}
