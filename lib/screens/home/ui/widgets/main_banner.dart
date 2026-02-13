import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.network(
              'https://graphicsfamily.com/wp-content/uploads/edd/2021/07/Fresh-and-healthy-vegetables-banner-design-template-scaled.jpg',
              height: 190,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              height: 190,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(.45), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            const Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Text(
                'تجربة تسوق\nأذكى وأسهل',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
