// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
//
// import '../../../../utils/resources/app_colors.dart';
// import '../home_screen.dart';
//
// class MainBottomNav extends StatefulWidget {
//   const MainBottomNav({super.key});
//
//   @override
//   State<MainBottomNav> createState() => _MainBottomNavState();
// }
//
// class _MainBottomNavState extends State<MainBottomNav> {
//   final _pageController = PageController();
//   int _index = 0;
//
//   final _icons = const [
//     Icons.home_outlined,
//     Icons.search,
//     Icons.favorite_border,
//     Icons.person_outline,
//   ];
//
//   void _goTo(int i) {
//     setState(() => _index = i);
//     _pageController.jumpToPage(i);
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kScaffoldBackground,
//       body: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: const [
//           HomeScreen(),
//           HomeScreen(),
//           HomeScreen(),
//           HomeScreen(),
//         ],
//       ),
//
//     );
//   }
// }
