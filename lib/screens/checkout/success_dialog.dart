import 'package:flutter/material.dart';
import 'package:moona/utils/resources/app_colors.dart';

class SuccessDialog extends StatelessWidget {
  final int orderId;

  const SuccessDialog({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// SUCCESS ICON
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kMainColor.withOpacity(0.1),
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                size: 60,
                color: kMainColor,
              ),
            ),

            const SizedBox(height: 20),

            /// TITLE
            const Text(
              'تم إنشاء الطلب بنجاح 🎉',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 12),

            /// ORDER ID
            Text(
              'رقم الطلب: #$orderId',
              style: const TextStyle(fontSize: 14, color: kSubtitleColor),
            ),

            const SizedBox(height: 24),

            /// BUTTON
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kMainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'تم',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
