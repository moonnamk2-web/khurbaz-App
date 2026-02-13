import 'package:flutter/material.dart';

Future<void> pushReplacement(
  BuildContext context,
  Widget screen,
) async {
  await Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}
