import 'package:flutter/material.dart';
import 'package:moona/utils/resources/app_colors.dart';

import 'home_slider_images.dart';

class HomeTopWidget extends StatelessWidget {
  const HomeTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: kSecMainColor,
                borderRadius: BorderRadiusGeometry.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              // child: HomeBanner(),
            ),
            Align(
              alignment: AlignmentGeometry.center,
              child: HomeSliderImages(),
            ),
          ],
        ),
      ),
    );
  }
}
