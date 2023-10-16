import 'package:flutter/material.dart';

abstract class AppColors {
  static final Color black = HexColor.fromHex('#000000');
  static final Color primaryDefault = HexColor.fromHex('#6C6CFF');
  static final Color primaryDark = HexColor.fromHex('#0A6B78');
  static final Color primaryLight = HexColor.fromHex('#E0FAFE');
  static final Color additionalMedium = HexColor.fromHex('#004B87');
  static final Color additionalLight = HexColor.fromHex('#D4F8CD');
  static final Color greyDark30 = HexColor.fromHex('#555555');
  static final Color grayLightBlue = HexColor.fromHex('##E3EBF2');
  static final Color wireframeLight = HexColor.fromHex('#F3F6F8');
  static final Color greyDark = HexColor.fromHex('#848A97');
  static final Color wireFrameMedium = HexColor.fromHex('#525C6B');
  static final Color wireFrameMedium2 = HexColor.fromHex('#9A9FA8');
  static final Color wireFrameDark = HexColor.fromHex('#0D272F');
  static final Color alertCritical = HexColor.fromHex('#FC3A40');
  static final Color white = HexColor.fromHex('#FFFFFF');
  static final Color graysInput = HexColor.fromHex('#F1F6FA');
  static final Color lightRed = HexColor.fromHex('#FAF1F1');
  static final Color secondaryRed = HexColor.fromHex('#F46F72');
  static final Color secondaryRedLight = HexColor.fromHex('##FAF1F1');
  static final Color secondaryDark = HexColor.fromHex('#1C1C37');
  static final Color webShopBlack = HexColor.fromHex('#1A1A1A');
  static final Color graysLight = HexColor.fromHex('#A1ADC5');
  static final Color graysUltraLight = HexColor.fromHex('#E1E9F3');
  static final Color graysMedium1 = HexColor.fromHex('#4E5373');
  static final Color graysMedium2 = HexColor.fromHex('#7A8BAC');
  static final Color appBarGrey = HexColor.fromHex('#F8F7FC');
  static final Color greyInput = HexColor.fromHex('#F9FBFF');
  static final Color datePickerBg = HexColor.fromHex('#19AEAE');
  static final Color chatBubble = HexColor.fromHex('#499999');

  static final LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: const [
      0.2,
      0.8,
    ],
    colors: [
      HexColor.fromHex('#4ED6DF'),
      HexColor.fromHex('#009FB5'),
    ],
  );

  static const SweepGradient secondaryGradient = SweepGradient(
    startAngle: 2.9,
    endAngle: 6.8,
    colors: [
      Color(0xFFF57376),
      Color(0xFF41B8D2),
      Color(0xFF41B8D2),
      Color(0xFFF57376),
    ],
    tileMode: TileMode.clamp,
  );
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
