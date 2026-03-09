class PaymentResponse {
  final String id;
  final String status;
  final String? token; // موجود إذا حفظت البطاقة
  final String? lastFour;

  PaymentResponse({
    required this.id,
    required this.status,
    this.token,
    this.lastFour,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      id: json['id'] ?? "",
      status: json['status'] ?? "",
      token: json['source']?['token'] ?? "",
      lastFour: json['source']?['last_four'] ?? "",
    );
  }
}
