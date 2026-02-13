import 'package:flutter/services.dart';

class PriceValidator {
  static List<TextInputFormatter> priceInputFormatters = [
    // Allow only numbers
    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    // Deny starts with Zero
    FilteringTextInputFormatter.deny(RegExp(r'^0')),
  ];
}
