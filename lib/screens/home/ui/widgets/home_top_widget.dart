import 'package:flutter/material.dart';
import 'package:moona/utils/resources/app_colors.dart';

import '../../models/slider_entity.dart';
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
              child: HomeSliderImages(
                sliderImages: [
                  SliderEntity(
                    id: 1,
                    image:
                        'https://graphicsfamily.com/wp-content/uploads/edd/2021/07/Fresh-and-healthy-vegetables-banner-design-template-scaled.jpg',
                  ),
                  SliderEntity(
                    id: 1,
                    image:
                        'https://img.freepik.com/premium-vector/healthy-food-promotion-banner-green-leaf-background_300191-221.jpg',
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
