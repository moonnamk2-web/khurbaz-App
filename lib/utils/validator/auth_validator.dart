class AuthValidator {
  static const int minPasswordLength = 6;

  /// Check if password length greater than or equals [minPasswordLength],
  /// then returns true
  static bool isPasswordLengthValid(String password) {
    return password.length >= minPasswordLength;
  }

  static bool isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/-=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$").hasMatch(email);
    // return RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[/a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(email);
  }

  static bool isPhoneNumberValid(String phone) {
    // Adjust the range in {8,15} based on your minimum and maximum length requirements
    return RegExp(r'^[0-9]{8,15}$').hasMatch(phone);
  }
  static bool isWhatsAppValid(String phone) {
    // Adjust the range in {8,15} based on your minimum and maximum length requirements
    return RegExp(r'^[0-9]{8,15}$').hasMatch(phone);
  }
}
