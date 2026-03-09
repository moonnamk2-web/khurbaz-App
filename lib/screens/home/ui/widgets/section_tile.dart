import 'package:flutter/material.dart';

import '../../../../utils/resources/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool showViewMore;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onTap,
    required this.showViewMore,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: kMainColor,
            ),
          ),
          const Spacer(),
          if (showViewMore)
            TextButton(
              onPressed: () => onTap(),
              child: const Text(
                'عرض الكل',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
