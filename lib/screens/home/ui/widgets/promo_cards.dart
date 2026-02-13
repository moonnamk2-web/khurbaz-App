import 'package:flutter/material.dart';

class PromoCards extends StatelessWidget {
  const PromoCards({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final items = [
            const PromoCard(
              title: 'منتجات جديدة',
              image:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBBxSTXBvCjJawBuVkQmgrcLd84JOTJlqXpg&s',
            ),
            const PromoCard(
              title: 'نظافة المنزل',
              image:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBBxSTXBvCjJawBuVkQmgrcLd84JOTJlqXpg&s',
            ),
          ];

          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: items[index],
          );
        },
      ),
    );
  }
}

class PromoCard extends StatelessWidget {
  final String title;
  final String image;

  const PromoCard({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Stack(
        children: [
          Image.network(
            image,
            height: 220,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            height: 220,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(.4), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
