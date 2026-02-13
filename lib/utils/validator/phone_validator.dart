class PhoneValidator {
  static const int _minPhoneLength = 5;

  static bool isPhoneNumberValid(String? phone) {
    return phone != null && phone.trim().length >= _minPhoneLength;
  }
  static bool isPhoneNumberInvalid(String? phone) {
    return !isPhoneNumberValid(phone);
  }

}