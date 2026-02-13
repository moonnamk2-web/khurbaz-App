import 'package:flutter/material.dart';

import '../../../../utils/resources/app_colors.dart';
import 'location_row.dart';

const Color lightGreen = Color(0xFFEAF4EF);
const Color light2Green = Color(0xFFCFE3C4);

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kSecMainColor,
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Row(
        children: [
          LocationRow(),
          const Spacer(),

          Image.asset('assets/images/logo.png', height: 100),
        ],
      ),
    );
  }
}
