import 'package:flutter/material.dart';

import '../../utils/resources/app_colors.dart';

class AboutKhurbazScreen extends StatelessWidget {
  const AboutKhurbazScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kScaffoldBackground,
        appBar: AppBar(
          title: const Text(
            "عن خربز",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: Image.asset('assets/images/logo-white.png'),
                ),
              ),

              const SizedBox(height: 30),

              Text(
                "مرحباً بك في خربز 👋🏻",
                style: TextStyle(
                  fontFamily: 'DINNextLT',
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: kMainColor,
                ),
              ),

              const SizedBox(height: 14),

              Text(
                "خربز هو ماركت سحابي مبتكر يجمع لك احتياجاتك اليومية في تجربة تسوق ذكية وسهلة. ",
                style: TextStyle(
                  fontFamily: 'DINNextLT',
                  fontSize: 14,
                  height: 1.8,
                  color: kTitleBodyColor,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                "نسعى لتقديم أفضل جودة، أسرع توصيل، وأفضل أسعار "
                "مع تجربة استخدام مريحة وآمنة.",
                style: TextStyle(
                  fontFamily: 'DINNextLT',
                  fontSize: 14,
                  height: 1.8,
                  color: kTitleBodyColor,
                ),
              ),

              const SizedBox(height: 30),

              Center(
                child: Text(
                  "نسخة التطبيق 1.0.0",
                  style: TextStyle(
                    fontFamily: 'DINNextLT',
                    fontSize: 13,
                    color: kTitleGreyColor,
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
