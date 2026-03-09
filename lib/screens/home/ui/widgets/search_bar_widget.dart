import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/utils/resources/app_colors.dart';

import '../../../../main.dart';
import '../../../../utils/helper/navigation/push_to.dart';
import '../../../search/uis/search_products_screen.dart';
import 'app_bar_widget.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pushTo(context, ProductSearchScreen()),
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: lightGreen,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                Icon(Icons.search, color: mainColor),
                Spacer(),
                Text(
                  'البحث عن منتجات',
                  style: TextStyle(
                    fontFamily: 'DINNextLT',
                    color: kMainColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                const SizedBox(width: 37),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
