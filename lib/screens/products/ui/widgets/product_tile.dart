import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moona/models/product_model.dart';

import '../../../../features/cart_summury/presentation/cubit/cart_summary_cubit.dart';
import '../../../../managers/server/cart/cart_api.dart';
import '../../../../utils/network/network_routes.dart';
import '../../../../utils/resources/app_colors.dart';
import '../../../../utils/widgets/cach_network_image_widget.dart';
import '../../../../utils/widgets/check_dialog.dart';
import '../../../../utils/widgets/currency.dart';

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

  Future<void> increment() async {
    if (loading) return;
    setState(() {
      loading = true;
      count++;
    });
    int? availableQuantity;
    try {
      if (widget.product.cartItemId == null) {
        widget.product.cartItemId = await CartApi.add(
          productId: widget.product.id,
          quantity: 1,
        );
      } else {
        availableQuantity = await CartApi.update(
          cartItemId: widget.product.cartItemId!,
          quantity: count,
        );
      }
      if (availableQuantity != null) {
        setState(() {
          loading = true;
          count--;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CheckDialog(
              text: 'هذه الكمية غير متاحة من المنتج',
              textButton: 'أكبر كمية متاحة',
              onCheck: () async {
                setState(() => count = availableQuantity!);
                Navigator.pop(context);
                return true;
              },
            );
          },
        );
      }
      context.read<CartSummaryCubit>().loadSummary();
    } catch (_) {
      setState(() => count--);
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
      context.read<CartSummaryCubit>().loadSummary();
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
                  Row(
                    children: [
                      Text(
                        '${widget.product.finalPrice}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Currency(),
                    ],
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
                    onTap: loading ? null : increment,
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
