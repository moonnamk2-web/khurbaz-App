class ProductModel {
  int id;
  int subCategoryId;
  int? brandId;
  int inCartQuantity;
  int? cartItemId;

  String name;
  String image;
  String description;

  double price;
  double? discountPrice;

  int? availableQuantity;
  bool enable;
  List<String>? images;

  DateTime createdAt;
  DateTime updatedAt;

  ProductModel({
    required this.id,
    required this.subCategoryId,
    required this.brandId,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.inCartQuantity,
    this.cartItemId,
    this.images,
    this.discountPrice,
    this.availableQuantity,
    required this.enable,
    required this.createdAt,
    required this.updatedAt,
  });

  /// ================= JSON =================

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> images = json['images'] ?? [];

    return ProductModel(
      id: json['id'],
      subCategoryId: json['sub_category_id'],
      brandId: json['brand_id'],
      inCartQuantity: json['in_cart_quantity'] ?? 0,
      cartItemId: json['cart_item_id'],
      image: images.isNotEmpty ? images[0]['image_url'] ?? "" : "",
      images: images.map((img) => img['image_url'].toString()).toList(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: double.parse(json['price'].toString()),
      discountPrice: json['discount_price'] != null
          ? double.parse(json['discount_price'].toString())
          : null,
      availableQuantity: json['available_quantity'],
      enable: json['enable'] == 1 || json['enable'] == true,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sub_category_id': subCategoryId,
      'brand_id': brandId,
      'name': name,
      'description': description,
      'price': price,
      'discount_price': discountPrice,
      'available_quantity': availableQuantity,
      'enable': enable,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// ================= Helpers =================

  bool get hasDiscount => discountPrice != null && discountPrice! < price;

  double get finalPrice => hasDiscount ? discountPrice! : price;

  bool get isAvailable => availableQuantity == null || availableQuantity! > 0;
}
