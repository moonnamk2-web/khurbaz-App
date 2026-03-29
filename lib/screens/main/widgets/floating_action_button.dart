import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/utils/helper/navigation/push_replacement.dart';

import '../../../features/cart_summury/presentation/cubit/cart_summary_cubit.dart';
import '../../../features/cart_summury/presentation/cubit/cart_summary_state.dart';
import '../../../utils/resources/app_colors.dart';
import '../../cart/ui/cart_screen.dart';

class FloatingActionButtonWidget extends StatefulWidget {
  const FloatingActionButtonWidget({super.key});

  @override
  State<FloatingActionButtonWidget> createState() =>
      _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState
    extends State<FloatingActionButtonWidget> {
  @override
  void initState() {
    super.initState();
    // load cart summary once FAB is built
    context.read<CartSummaryCubit>().loadSummary();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartSummaryCubit, CartSummaryState>(
      builder: (_, state) {
        final int badgeCount = state.summary?.totalItems ?? 0;

        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: FloatingActionButton(
            onPressed: () {
              pushReplacement(context, CartScreen(fromMain: true));
            },
            backgroundColor: kMainColor,
            child: badges.Badge(
              position: badges.BadgePosition.topStart(top: 4, start: 4),
              showBadge: badgeCount > 0,
              badgeAnimation: const badges.BadgeAnimation.scale(),
              badgeStyle: badges.BadgeStyle(
                badgeColor: Colors.red,
                elevation: 0,
                padding: const EdgeInsets.all(6),
              ),
              badgeContent: Text(
                badgeCount.toString(),
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/cart.svg',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
