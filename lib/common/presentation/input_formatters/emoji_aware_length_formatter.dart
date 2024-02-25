import 'package:flutter/services.dart';

class EmojisAwareLengthFormatter extends TextInputFormatter {
  final int allowedLength;

  EmojisAwareLengthFormatter({required this.allowedLength});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length <= allowedLength) {
      return newValue;
    }
    return oldValue;
  }
}
