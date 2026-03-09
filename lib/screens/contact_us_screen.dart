import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/resources/app_colors.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kScaffoldBackground,
        appBar: AppBar(
          title: const Text(
            "تواصل معنا",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              _ContactCard(
                icon: Icons.phone,
                title: "رقم الهاتف",
                value: "+966 5XXXXXXXX",
              ),

              const SizedBox(height: 16),

              _ContactCard(
                icon: Icons.email_outlined,
                title: "البريد الإلكتروني",
                value: "support@khurbaz.com",
              ),

              const SizedBox(height: 16),

              _ContactCard(
                icon: Icons.access_time,
                title: "ساعات العمل",
                value: "يومياً من 9 صباحاً حتى 11 مساءً",
              ),

              const SizedBox(height: 30),

              Text(
                "نحن هنا لخدمتك دائماً 🤍",
                style: TextStyle(
                  fontFamily: 'DINNextLT',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: kMainColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: kMainColor.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: kMainColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: kMainColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'DINNextLT',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'DINNextLT',
                    fontSize: 13,
                    color: kTitleGreyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
