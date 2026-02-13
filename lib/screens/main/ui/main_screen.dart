import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moona/utils/helper/navigation/push_to.dart';

import '../../../utils/resources/app_colors.dart';
import '../../cart/ui/cart_screen.dart';
import '../../categories/ui/categories_screen.dart';
import '../../home/ui/home_screen.dart';
import '../../home/ui/widgets/app_bar_widget.dart';
import '../../orders/orders_screen.dart';
import '../more_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    CategoriesScreen(),
    OrdersScreen(), // طلباتي
    MoreScreen(), // المزيد
  ];

  void _onTap(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ColoredBox(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: light2Green,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: FloatingActionButton(
                onPressed: () {
                  pushTo(context, CartScreen());
                },
                backgroundColor: kMainColor,
                child: SvgPicture.asset(
                  'assets/images/cart.svg',
                  color: Colors.white,
                ),
              ),
            ),
            body: Stack(
              children: [
                _screens[_currentIndex],

                Align(
                  alignment: Alignment.bottomCenter,
                  child: _FloatingNavBar(
                    currentIndex: _currentIndex,
                    onTap: _onTap,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _FloatingNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 66,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: 'assets/images/home.svg',
              title: 'الرئيسية',
              active: currentIndex == 0,
              onTap: () => onTap(0),
            ),
            _NavItem(
              icon: 'assets/images/categories.svg',
              title: 'التصنيفات',
              active: currentIndex == 1,
              onTap: () => onTap(1),
            ),
            SizedBox(width: 40),
            _NavItem(
              icon: 'assets/images/orders.svg',
              title: 'طلباتي',
              active: currentIndex == 2,
              onTap: () => onTap(2),
            ),
            _NavItem(
              icon: 'assets/images/more.svg',
              title: 'المزيد',
              active: currentIndex == 3,
              onTap: () => onTap(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String icon;
  final String title;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? kMainColor : kTitleGreyColor;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon, color: color, height: 22),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
