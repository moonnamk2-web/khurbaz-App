class SubCategoryModel {
  final int id;
  final int categoryId;
  final String arName;
  final String enName;
  final String imageUrl;
  final String? homeBanner;

  SubCategoryModel({
    required this.id,
    required this.categoryId,
    required this.arName,
    required this.enName,
    required this.imageUrl,
    this.homeBanner,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      categoryId: json['category_id'],
      arName: json['ar_name'],
      enName: json['en_name'],
      imageUrl: json['image_url'] ?? '',
      homeBanner: json['home_banner_url'] ?? '',
    );
  }

  String title(String locale) => locale.startsWith('ar') ? arName : enName;
}
