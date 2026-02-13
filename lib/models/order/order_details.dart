class OrderDetailsModel {
  final int id;
  final DateTime date;
  final double grandTotal;
  final String status;
  final String address;
  final List<OrderItemModel> items;

  OrderDetailsModel({
    required this.id,
    required this.date,
    required this.grandTotal,
    required this.status,
    required this.address,
    required this.items,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      id: json['id'],
      date: DateTime.parse(json['created_at']),
      grandTotal: double.parse(json['grand_total'].toString()),
      status: json['status'],
      address: json['address']['location_name'] ?? '',
      items: (json['items'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
    );
  }
}

class OrderItemModel {
  final int productId;
  final String name;
  final String image;
  final int quantity;
  final double price;

  OrderItemModel({
    required this.productId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['product_id'],
      quantity: json['quantity'],
      price: double.parse(json['price'].toString()),
      name: json['product']['name'],
      image: json['product']['images'].isNotEmpty
          ? json['product']['images'][0]['image_url']
          : '',
    );
  }
}
