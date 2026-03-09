import 'package:flutter/material.dart';

import '../../utils/helper/navigation/push_to.dart';
import '../../utils/resources/app_colors.dart';
import '../auth/uis/screens/login_screen.dart';
import '../auth/uis/screens/signup_screen.dart';

class SignupSection extends StatelessWidget {
  const SignupSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// HEADER
        Text(
          'أهلاً!',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: kMainColor,
          ),
        ),
        const SizedBox(height: 8),
        Image.asset('assets/images/register.jpeg', height: 300),
        const SizedBox(height: 8),

        const Text(
          'مستخدم جديد؟ قم بإنشاء حساب جديد.',
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),

        const SizedBox(height: 24),

        /// CREATE ACCOUNT BUTTON
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: () {
              pushTo(context, RegisterScreen());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kMainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
            ),
            child: const Text(
              'إنشاء حساب',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        /// LOGIN
        GestureDetector(
          onTap: () {
            pushTo(context, LoginScreen());
          },
          child: const Text(
            'هل لديك حساب؟ تسجيل الدخول',
            style: TextStyle(color: kMainColor, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
