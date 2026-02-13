import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../utils/network/network_routes.dart';
import '../entities/address_entity.dart';

class AddressRemoteSource {
  AddressRemoteSource();

  final client = http.Client();

  // --------------------------
  // GET ADDRESSES
  // --------------------------
  Future<List<AddressEntity>> getAddresses() async {
    final uri = Uri.parse('$baseUrl/addresses');
    final response = await client.get(uri, headers: headersWithToken);
    final decoded = json.decode(response.body);

    print('=======getAddresses : ${decoded}');
    if (response.statusCode != 200) {
      throw Exception('Failed to load addresses');
    }

    if (decoded is Map<String, dynamic>) {
      final List list = decoded['addresses'];
      return list.map((e) => AddressEntity.fromJson(e)).toList();
    }

    throw Exception('Invalid addresses format');
  }

  // --------------------------
  // ADD ADDRESS
  // --------------------------
  Future<void> addAddress({required Map<String, dynamic> body}) async {
    final uri = Uri.parse('$baseUrl/addresses');

    final response = await client.post(
      uri,
      headers: headersWithToken,
      body: json.encode(body),
    );
    print('=======addAddress : ${response.body}');

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add address');
    }
  }

  // --------------------------
  // DELETE ADDRESS
  // --------------------------
  Future<void> deleteAddress({required int id}) async {
    final uri = Uri.parse('$baseUrl/addresses/$id');

    final response = await client.delete(uri, headers: headersWithToken);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete address');
    }
  }

  // --------------------------
  // SET DEFAULT
  // --------------------------
  Future<void> setDefaultAddress({required int id}) async {
    final uri = Uri.parse('$baseUrl/addresses/default');

    final response = await client.post(
      uri,
      headers: headersWithToken,
      body: jsonEncode({'id': id}),
    );
    print('=======setDefaultAddress : ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to set default address');
    }
  }
}
