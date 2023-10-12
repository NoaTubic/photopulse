import 'package:flutter/material.dart';

final class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle? regular;
  final TextStyle? bold;
  final TextStyle? boldLarge;

  const AppTextStyles({
    required this.regular,
    required this.bold,
    required this.boldLarge,
  });

  @override
  AppTextStyles copyWith({
    TextStyle? regular,
    TextStyle? bold,
    TextStyle? boldLarge,
  }) {
    return AppTextStyles(
      regular: regular ?? this.regular,
      bold: bold ?? this.bold,
      boldLarge: boldLarge ?? this.boldLarge,
    );
  }

  @override
  AppTextStyles lerp(AppTextStyles? other, double t) {
    if (other is! AppTextStyles) {
      return this;
    }
    return AppTextStyles(
      regular: TextStyle.lerp(regular, other.regular, t),
      bold: TextStyle.lerp(bold, other.bold, t),
      boldLarge: TextStyle.lerp(boldLarge, other.boldLarge, t),
    );
  }
}

AppTextStyles getAppTextStyles({required Color defaultColor}) {
  final baseTextStyle = TextStyle(
    color: defaultColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );
  return AppTextStyles(
    regular: baseTextStyle,
    bold: baseTextStyle.copyWith(fontWeight: FontWeight.w700),
    boldLarge:
        baseTextStyle.copyWith(fontWeight: FontWeight.w700, fontSize: 24),
  );
}
