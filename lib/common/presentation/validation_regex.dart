abstract class ValidationRegex {
  static const String password =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!%@#\$&*~]).{8,}$';
}
