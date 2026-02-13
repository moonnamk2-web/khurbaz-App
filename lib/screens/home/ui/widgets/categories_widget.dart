import 'package:flutter/material.dart';
import 'package:moona/models/category_model.dart';

import '../../../../managers/server/categories/categories_api.dart';
import '../../../../utils/helper/navigation/push_to.dart';
import '../../../../utils/resources/app_colors.dart';
import '../../../../utils/widgets/cach_network_image_widget.dart';
import '../../../products/ui/products_screen.dart';

class CategoriesHorizontalGrid extends StatefulWidget {
  const CategoriesHorizontalGrid({super.key});

  @override
  State<CategoriesHorizontalGrid> createState() =>
      _CategoriesHorizontalGridState();
}

class _CategoriesHorizontalGridState extends State<CategoriesHorizontalGrid> {
  late Future<List<CategoryModel>> future;

  @override
  void initState() {
    super.initState();
    future = CategoriesApi.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<CategoryModel>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text('فشل تحميل التصنيفات'));
            }

            final categories = snapshot.data!;
            if (categories.isEmpty) {
              return const Center(child: Text('لا يوجد تصنيفات'));
            }

            return GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final item = categories[index];
                return GestureDetector(
                  onTap: () {
                    pushTo(
                      context,
                      ProductsScreen(
                        categoryId: item.id,
                        title: item.arName,
                        daily: false,
                        hasDiscount: false,
                      ),
                    );
                  },
                  child: CategoryTile(title: item.arName, img: item.imageUrl),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String title;
  final String img;

  const CategoryTile({super.key, required this.title, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorderOverlayColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: kTitleBodyColor,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: CacheNetworkImageWidget(url: img, width: double.infinity),
            ),
          ],
        ),
      ),
    );
  }
}
