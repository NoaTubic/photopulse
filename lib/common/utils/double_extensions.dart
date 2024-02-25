extension DoubleExtension on double {
  double rounded(int fractionDigits) {
    return double.parse(toStringAsFixed(fractionDigits));
  }
}
