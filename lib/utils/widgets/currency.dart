import 'package:flutter/cupertino.dart';

class Currency extends StatelessWidget {
  const Currency({super.key, this.isRed});

  final bool? isRed;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      isRed != null && isRed!
          ? 'assets/images/sar-red.png'
          : 'assets/images/sar.jpeg',
      width: 20,
      height: 20,
    );
  }
}
