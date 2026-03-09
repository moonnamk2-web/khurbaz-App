class BannerModel {
  final int id;
  final String url;
  final int? categoryId;

  BannerModel({required this.id, required this.url, this.categoryId});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      url: json['url'] ?? '',
      categoryId: json['category_id'],
    );
  }
}
