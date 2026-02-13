import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalProductsShimmer extends StatelessWidget {
  const HorizontalProductsShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240, // مناسب لكرت أفقي مثل ProductCard
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: itemCount,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (_, __) => const _HorizontalProductSkeleton(),
      ),
    );
  }
}

class _HorizontalProductSkeleton extends StatelessWidget {
  const _HorizontalProductSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Container(
              height: 130,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
            ),

            // TITLE (2 lines)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 12,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 6),
                  Container(height: 12, width: 90, color: Colors.white),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // PRICE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(height: 14, width: 70, color: Colors.white),
            ),

            const Spacer(),

            // ADD BUTTON AREA (bottom-right like your card)
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 34,
                width: 54,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 10, right: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
