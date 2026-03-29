import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moona/utils/network/network_routes.dart';
import 'package:moona/utils/widgets/cach_network_image_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/helper/navigation/push_to.dart';
import '../../../../utils/resources/app_colors.dart';
import '../../../products/ui/products_screen.dart';
import '../../models/banner.dart';

class HomeSliderImages extends StatefulWidget {
  const HomeSliderImages({super.key});

  @override
  State<HomeSliderImages> createState() => _HomeSliderImagesState();
}

class _HomeSliderImagesState extends State<HomeSliderImages> {
  List<BannerModel> banners = [];
  bool loading = true;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadBanners();
  }

  Future<void> _loadBanners() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/banners"));

      print('==============banners ${response.body}');
      final data = jsonDecode(response.body);

      final List list = data['banners'] ?? [];

      banners = list.map((e) => BannerModel.fromJson(e)).toList();
    } catch (e) {
      banners = [];
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (loading) {
      return SizedBox(
        height: 240,
        child: Shimmer.fromColors(
          baseColor: kMainColor.withOpacity(0.3),
          highlightColor: Colors.white,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 240,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
      );
    }

    if (banners.isEmpty) return const SizedBox();

    return SizedBox(
      height: 240,
      width: double.infinity,

      child: CarouselSlider.builder(
        itemCount: banners.length,
        options: CarouselOptions(
          viewportFraction: 0.85,
          enlargeCenterPage: true,
          autoPlay: banners.length > 1,
          enableInfiniteScroll: banners.length > 1,
          onPageChanged: (index, reason) {
            setState(() => currentIndex = index);
          },
        ),
        itemBuilder: (context, index, realIndex) {
          final banner = banners[index];

          return Center(
            child: GestureDetector(
              onTap: () {
                if (banner.categoryId != null) {
                  pushTo(
                    context,
                    ProductsScreen(
                      categoryId: banner.categoryId!,
                      daily: false,
                      hasDiscount: false,
                      title: '',
                    ),
                  );
                }
              },
              child: CacheNetworkImageWidget(
                url: bannersImagePathUrl + banner.url,
                width: double.infinity,
              ),
            ),
          );
        },
      ),
    );
  }
}
