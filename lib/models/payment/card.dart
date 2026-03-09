class CardModel {
  final String name;
  final String number;
  final int month;
  final int year;
  final int cvc;
  final String statementDescriptor;
  final String? token;
  final String? lastFour;
  final bool saveCard;

  CardModel({
    required this.name,
    required this.number,
    required this.month,
    required this.year,
    required this.cvc,
    required this.statementDescriptor,
    this.saveCard = false,
    this.token,
    this.lastFour,
  });

  /// 🔹 تحويل إلى JSON (لإرسالها إلى الـ API)
  Map<String, dynamic> toJson() {
    return {
      'type': 'creditcard',
      'name': name,
      'number': number,
      'month': month,
      'year': year,
      'token': token,
      'last_four': lastFour,
      'cvc': cvc.toString(),
      'statement_descriptor': statementDescriptor,
      'save_card': saveCard,
      '3ds': true,
      'manual': false,
    };
  }

  /// 🔹 إنشاء كائن من JSON (عند الاستقبال من السيرفر)
  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      name: json['card_name'] ?? '',
      number: json['number'] ?? '',
      token: json['token'] ?? '',
      lastFour: json['last_four'] ?? '',
      month: int.tryParse(json['month'].toString()) ?? 1,
      year: int.tryParse(json['year'].toString()) ?? DateTime.now().year,
      cvc: int.tryParse(json['cvc'].toString()) ?? 0,
      statementDescriptor: json['statement_descriptor'] ?? '',
      saveCard: json['save_card'] ?? false,
    );
  }

  /// 🔹 إنشاء قائمة من JSON List
  static List<CardModel> fromJsonList(List<dynamic> list) {
    return list.map((e) => CardModel.fromJson(e)).toList();
  }
}
