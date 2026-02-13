import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/resources/app_colors.dart';
import '../../models/slider_entity.dart';

class HomeSliderImages extends StatefulWidget {
  const HomeSliderImages({super.key, required this.sliderImages});

  final List<SliderEntity> sliderImages;

  @override
  State<HomeSliderImages> createState() => _HomeSliderImagesState();
}

class _HomeSliderImagesState extends State<HomeSliderImages> {
  int newIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: 240,
      child: CarouselSlider.builder(
        options: CarouselOptions(
          viewportFraction: 0.85,
          aspectRatio: 0,
          enlargeCenterPage: true,
          height: 240,
          autoPlay: widget.sliderImages.length > 1 ? true : false,
          enableInfiniteScroll: widget.sliderImages.length > 1 ? true : false,
          onPageChanged: (index, reason) {
            setState(() {
              newIndex = index;
            });
          },
          autoPlayAnimationDuration: const Duration(seconds: 2),
        ),
        itemCount: widget.sliderImages.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return Center(
            child: CachedNetworkImage(
              imageUrl: widget.sliderImages[index].image.toString(),
              imageBuilder: (context, imageProvider) => Material(
                elevation: 2,
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  child: Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    height: size.height * 0.35,
                    width: size.width * 0.95,
                  ),
                ),
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  SizedBox(
                    height: size.height * 0.35,
                    width: size.width * 0.95,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Shimmer.fromColors(
                        baseColor: kMainColor.withOpacity(0.8),
                        highlightColor: Colors.white,
                        child: SizedBox(
                          height: size.height * 0.35,
                          width: size.width * 0.95,
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          );
        },
      ),
    );
  }
}
