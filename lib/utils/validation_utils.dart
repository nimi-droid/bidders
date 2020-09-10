/*
 * Validators
 */
// ignore: avoid_classes_with_only_static_members
class ValidationUtils {
  static final RegExp _alphabetRegex = RegExp(r'^[a-zA-Z]+$');
  static final RegExp _emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  static bool isValidPhoneNumber(String number) {
    if (number.isEmpty || number.length < 10)
      return false;
    else
      return true;
  }

  static String validatePhoneNumber(String value) {
    if (value.isEmpty)
      return 'Phone number is required.';
    else if (value.length < 10 && value.length > 10)
      return 'Enter valid 10 digit phone number';
    else
      return null;
  }

  static String validateEmail(String value) {
    if (value.isEmpty) return 'Please enter email address';
    return null;
  }

  static String validatePassword(String value) {
    if (value != null && value.isEmpty) return 'Password is required.';
    return null;
  }

  static bool isValidName(String s) {
    return _alphabetRegex.hasMatch(s);
  }

  static bool isValidEmail(String email) {
    return _emailRegex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return password != null && password.length >= 6;
  }
}
