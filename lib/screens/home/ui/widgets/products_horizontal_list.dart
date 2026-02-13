import 'package:flutter/material.dart';

import '../../../../managers/server/products/products_api.dart';
import '../../../../models/product_model.dart';
import '../../../../utils/widgets/shimmers/horizontal_products_shimmer.dart';
import '../../../products/ui/widgets/product_card.dart';

class ProductHorizontalList extends StatefulWidget {
  const ProductHorizontalList({
    super.key,
    required this.daily,
    required this.hasDiscount,
  });

  final bool daily;
  final bool hasDiscount;

  @override
  State<ProductHorizontalList> createState() => _ProductHorizontalListState();
}

class _ProductHorizontalListState extends State<ProductHorizontalList> {
  List<ProductModel> products = [];
  bool loadingProducts = true;

  Future<void> _loadProducts() async {
    loadingProducts = true;
    products.clear();

    setState(() {});

    final res = await ProductsApi.getProducts(
      page: 1,
      daily: widget.daily,
      hasDiscount: widget.hasDiscount,
    );

    products = res;

    loadingProducts = false;
    setState(() {});
  }

  @override
  void initState() {
    _loadProducts();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 257,
        child: loadingProducts
            ? HorizontalProductsShimmer()
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 8),
                itemCount: products.length,
                itemBuilder: (_, i) {
                  return ProductCard(product: products[i], onPop: () {});
                },
              ),
      ),
    );
  }
}
