import 'package:flutter/services.dart';

class RuneAwareLengthFormatter extends TextInputFormatter {
  final int allowedLength;

  RuneAwareLengthFormatter({required this.allowedLength});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.runes.length > allowedLength) return oldValue;
    return newValue;
  }
}
