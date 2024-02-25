import 'package:flutter/material.dart';

abstract class AppColors {
  static final Color black = HexColor.fromHex('#121212');
  static final Color white = HexColor.fromHex('#FFFFFF');
  static final Color accentDark = HexColor.fromHex('#2B2B2B');

  static final Color mainLight = HexColor.fromHex('#FFFFFF');
  static final Color secondaryLight = HexColor.fromHex('#1C1C1C');
  static final Color accentLight = HexColor.fromHex('#F3F2F2');

  static final Color alertCritical = HexColor.fromHex('#FC3A40');
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    var tmpHexColorString = hexColorString.replaceAll('#', '');
    if (tmpHexColorString.length == 6) {
      tmpHexColorString = '0xFF$tmpHexColorString';
    } else {
      tmpHexColorString = '0x$tmpHexColorString';
    }
    return Color(int.parse(tmpHexColorString));
  }
}
