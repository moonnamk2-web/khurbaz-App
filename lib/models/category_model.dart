import 'package:moona/models/sub_category_model.dart';

class CategoryModel {
  final int id;
  final String arName;
  final String enName;
  final String imageUrl;
  final List<SubCategoryModel> subCategories;

  CategoryModel({
    required this.id,
    required this.arName,
    required this.enName,
    required this.imageUrl,
    required this.subCategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      arName: json['ar_name'],
      enName: json['en_name'],
      imageUrl: json['image_url'] ?? '',
      subCategories: (json['sub_categories'] as List? ?? [])
          .map((e) => SubCategoryModel.fromJson(e))
          .toList(),
    );
  }

  String title(String locale) => locale.startsWith('ar') ? arName : enName;
}
