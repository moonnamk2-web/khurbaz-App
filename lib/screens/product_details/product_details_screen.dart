import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moona/utils/helper/navigation/push_to.dart';
import 'package:moona/utils/resources/app_colors.dart';
import 'package:moona/utils/widgets/cach_network_image_widget.dart';

import '../../features/cart_summury/presentation/cubit/cart_summary_cubit.dart';
import '../../features/cart_summury/presentation/cubit/cart_summary_state.dart';
import '../../managers/server/cart/cart_api.dart';
import '../../managers/server/products/products_api.dart';
import '../../models/product_model.dart';
import '../../utils/network/network_routes.dart';
import '../../utils/widgets/check_dialog.dart';
import '../cart/ui/cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late Future<ProductModel> future;

  int quantity = 0; // ✅ يبدأ من 0
  bool initialized = false;
  bool loading = false;

  int currentImage = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    future = ProductsApi.getProduct(widget.productId);
  }

  /// init quantity ONCE from server
  void _init(ProductModel product) {
    if (initialized) return;
    quantity = product.inCartQuantity;
    initialized = true;
  }

  Future<void> _add(ProductModel product) async {
    if (loading) return;

    final newQty = quantity + 1;

    setState(() {
      loading = true;
      quantity = newQty;
    });

    try {
      int? availableQuantity;

      if (product.cartItemId == null) {
        product.cartItemId = await CartApi.add(
          productId: product.id,
          quantity: newQty,
        );

        // re-fetch to get cart_item_id
        final refreshed = await ProductsApi.getProduct(product.id);
        product.cartItemId = refreshed.cartItemId;
      } else {
        availableQuantity = await CartApi.update(
          cartItemId: product.cartItemId!,
          quantity: quantity,
        );
      }
      if (availableQuantity != null) {
        setState(() {
          loading = true;
          quantity--;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CheckDialog(
              text: 'هذه الكمية غير متاحة من المنتج',
              textButton: 'أكبر كمية متاحة',
              onCheck: () async {
                setState(() => quantity = availableQuantity!);
                Navigator.pop(context);
                return true;
              },
            );
          },
        );
      }
      context.read<CartSummaryCubit>().loadSummary();

      product.inCartQuantity = newQty;
    } catch (_) {
      quantity--; // rollback
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> _remove(ProductModel product) async {
    if (loading || quantity == 0) return;

    final newQty = quantity - 1;

    setState(() {
      loading = true;
      quantity = newQty;
    });

    try {
      if (newQty == 0) {
        await CartApi.remove(product.cartItemId!);
        product.cartItemId = null;
        product.inCartQuantity = 0;
      } else {
        await CartApi.update(cartItemId: product.cartItemId!, quantity: newQty);
        product.inCartQuantity = newQty;
      }
      context.read<CartSummaryCubit>().loadSummary();
    } catch (_) {
      quantity++; // rollback
    } finally {
      setState(() => loading = false);
    }
  }

  void _onImageTap(int index) {
    setState(() => currentImage = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<ProductModel>(
          future: future,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final product = snapshot.data!;
            final images = product.images ?? [];

            _init(product);

            return SafeArea(
              child: Column(
                children: [
                  /// ================= IMAGES =================
                  SizedBox(
                    height: 300,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          itemCount: images.isEmpty ? 1 : images.length,
                          onPageChanged: (i) =>
                              setState(() => currentImage = i),
                          itemBuilder: (_, index) {
                            final img = images.isEmpty
                                ? product.image
                                : images[index];

                            return Container(
                              margin: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.grey.shade100,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: CacheNetworkImageWidget(
                                  url: productsImagePathUrl + img,
                                  width: double.infinity,
                                ),
                              ),
                            );
                          },
                        ),

                        if (images.length > 1)
                          Positioned(
                            bottom: 20,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(images.length, (i) {
                                final active = i == currentImage;
                                return GestureDetector(
                                  onTap: () => _onImageTap(i),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                    ),
                                    height: 52,
                                    width: 52,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: active
                                            ? kMainColor
                                            : Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CacheNetworkImageWidget(
                                        url: productsImagePathUrl + images[i],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),

                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _TopIcon(
                                icon: Icons.arrow_back,
                                onTap: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// ================= CONTENT =================
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// TITLE + PRICE
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              // PRICE
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: product.hasDiscount
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // OLD PRICE (LINE THROUGH)
                                          Text(
                                            '${product.price} ريال',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade500,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                          const SizedBox(width: 4),

                                          // DISCOUNT PRICE
                                          Text(
                                            '${product.finalPrice} ريال',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: kMainColor,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        '${product.price} ريال',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: kMainColor,
                                        ),
                                      ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          Text(
                            product.description,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.7,
                              color: Colors.grey.shade700,
                            ),
                          ),

                          const SizedBox(height: 24),

                          const Text(
                            'الكمية',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),

                          /// COUNTER (THE ONLY UPDATE SOURCE)
                          product.availableQuantity! <= 0
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(4.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.red.withOpacity(0.1),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'الكمية نفذت',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.red,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    _QtyButton(
                                      icon: Icons.add,
                                      onTap: loading
                                          ? null
                                          : () => _add(product),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                      ),
                                      child: loading
                                          ? const SizedBox(
                                              height: 18,
                                              width: 18,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: kMainColor,
                                              ),
                                            )
                                          : Text(
                                              '$quantity',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                    ),
                                    _QtyButton(
                                      icon: Icons.remove,
                                      onTap: loading || quantity == 0
                                          ? null
                                          : () => _remove(product),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),

                  /// ================= BOTTOM ACTION =================
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: quantity == 0
                            ? () => _add(product)
                            : () =>
                                  pushTo(context, CartScreen(fromMain: false)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kMainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          spacing: 16,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocBuilder<CartSummaryCubit, CartSummaryState>(
                              builder: (_, state) {
                                final int badgeCount =
                                    state.summary?.totalItems ?? 0;

                                return badges.Badge(
                                  position: badges.BadgePosition.topStart(
                                    top: 4,
                                  ),
                                  showBadge: badgeCount > 0,
                                  badgeAnimation:
                                      const badges.BadgeAnimation.scale(),
                                  badgeStyle: badges.BadgeStyle(
                                    badgeColor: Colors.red,
                                    elevation: 0,
                                    padding: const EdgeInsets.all(6),
                                  ),
                                  badgeContent: Text(
                                    badgeCount.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10,
                                    ),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/images/cart.svg',
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Text(
                              quantity == 0 ? 'أضف إلى السلة' : 'عرض السلة',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// ================= HELPERS =================

class _TopIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TopIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: kMainColor),
        ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon),
      ),
    );
  }
}
