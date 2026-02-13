import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/screens/auth/uis/screens/login_screen.dart';
import 'package:moona/screens/auth/uis/screens/signup_screen.dart';
import 'package:moona/screens/main/ui/main_screen.dart';
import 'package:moona/state-managment/bloc/auth/auth_cubit.dart';
import 'package:moona/utils/helper/navigation/push_to.dart';

import '../../managers/cash_manager.dart';
import '../../utils/helper/navigation/push_replacement.dart';
import '../../utils/resources/app_colors.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kScaffoldBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  if (AuthCubit.user != null)
                    /// HEADER
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            Text(
                              'أهلاً',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              AuthCubit.user!.fullName,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                color: kMainColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Image.asset('assets/images/logo.png', height: 300),
                      ],
                    ),
                  if (AuthCubit.user == null)
                    Column(
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
                            style: TextStyle(
                              color: kMainColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 24),

                  /// MENU ITEMS
                  _MoreItem(
                    icon: Icons.phone_outlined,
                    title: 'تواصل معنا',
                    onTap: () {},
                  ),
                  _MoreItem(
                    icon: Icons.info_outline,
                    title: 'عن Moona',
                    onTap: () {},
                  ),
                  _MoreItem(
                    icon: Icons.privacy_tip_outlined,
                    title: 'سياسة الخصوصية',
                    onTap: () {},
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// LOGOUT
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            CacheManager.getInstance()!.logout();
                            AuthCubit.user = null;
                            pushReplacement(context, const MainScreen());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kMainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              spacing: 8,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/sign-out-alt.svg',
                                  width: 18,
                                  color: Colors.white,
                                ),
                                Text(
                                  'تسجيل خروج',
                                  style: GoogleFonts.cairo(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      /// DELETE ACCOUNT
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4.0,
                          vertical: 8,
                        ),
                        child: ElevatedButton(
                          onPressed: () async {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'حذف الحساب',
                              style: GoogleFonts.cairo(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MoreItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;

  const _MoreItem({
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: kMainColor),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.black45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
