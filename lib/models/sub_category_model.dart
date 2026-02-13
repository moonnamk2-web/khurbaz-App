class SubCategoryModel {
  final int id;
  final String arName;
  final String enName;
  final String imageUrl;

  SubCategoryModel({
    required this.id,
    required this.arName,
    required this.enName,
    required this.imageUrl,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      arName: json['ar_name'],
      enName: json['en_name'],
      imageUrl: json['image_url'] ?? '',
    );
  }

  String title(String locale) => locale.startsWith('ar') ? arName : enName;
}
