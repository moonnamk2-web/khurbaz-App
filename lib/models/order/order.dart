class OrderModel {
  final int id;
  final String date;
  final double total;
  final String status;

  OrderModel({
    required this.id,
    required this.date,
    required this.total,
    required this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      date: json['created_at'].toString(),
      total: double.parse(json['grand_total'].toString()),
      status: json['status'],
    );
  }
}
