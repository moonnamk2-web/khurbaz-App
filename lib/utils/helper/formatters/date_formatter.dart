import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('d MMMM y', 'ar').format(date);
}

String formatDate2(DateTime date, BuildContext context) {
  final formatter = DateFormat('d EEEE ، MMMM y', 'ar');
  return '${formatter.format(date)}م';
}
