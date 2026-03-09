import 'package:flutter/material.dart';
import 'package:moona/models/product_model.dart';

import '../../../../managers/server/cart/cart_api.dart';
import '../../../../utils/network/network_routes.dart';
import '../../../../utils/resources/app_colors.dart';
import '../../../../utils/widgets/cach_network_image_widget.dart';

class ProductCartTile extends StatefulWidget {
  const ProductCartTile(this.product, {super.key});

  final ProductModel product;

  @override
  State<ProductCartTile> createState() => ProductCartTileState();
}

class ProductCartTileState extends State<ProductCartTile> {
  late int count;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    count = widget.product.inCartQuantity;
  }

  Future<void> _add() async {
    if (loading) return;

    setState(() {
      loading = true;
      count++;
    });

    try {
      await CartApi.update(
        cartItemId: widget.product.cartItemId!,
        quantity: count,
      );
    } catch (_) {
      setState(() => count--); // rollback
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> _remove() async {
    if (loading || count <= 0) return;

    setState(() {
      loading = true;
      count--;
    });

    try {
      if (count == 0) {
        await CartApi.remove(widget.product.cartItemId!);
      } else {
        await CartApi.update(
          cartItemId: widget.product.cartItemId!,
          quantity: count,
        );
      }
    } catch (_) {
      setState(() => count++); // rollback
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: count == 0 ? 0.3 : 1,
      child: Container(
        height: 120,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            /// IMAGE
            Container(
              height: 100,
              width: 100,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: kScaffoldBackground,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: CacheNetworkImageWidget(
                  url: productsImagePathUrl + widget.product.image,
                ),
              ),
            ),

            const SizedBox(width: 12),

            /// NAME + PRICE
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${widget.product.finalPrice} ﷼',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kMainColor,
                    ),
                  ),
                ],
              ),
            ),

            /// COUNTER
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                border: const Border(
                  left: BorderSide(color: kMainColor, width: 1.5),
                ),
              ),
              child: Column(
                children: [
                  // REMOVE
                  GestureDetector(
                    onTap: loading ? null : _remove,
                    child: Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: const BoxDecoration(
                        color: kMainColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),

                  const Spacer(),

                  Text(
                    '$count',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: kMainColor,
                    ),
                  ),

                  const Spacer(),

                  // ADD
                  GestureDetector(
                    onTap: loading ? null : _add,
                    child: Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: const BoxDecoration(
                        color: kMainColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
