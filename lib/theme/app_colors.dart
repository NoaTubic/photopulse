import 'package:flutter/material.dart';

final class AppColors extends ThemeExtension<AppColors> {
  final Color? defaultColor;
  final Color? secondary;
  final Color? background;

  const AppColors({
    required this.defaultColor,
    required this.secondary,
    required this.background,
  });

  @override
  AppColors copyWith({
    Color? defaultColor,
    Color? secondary,
    Color? background,
  }) {
    return AppColors(
      defaultColor: defaultColor ?? this.defaultColor,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      defaultColor: Color.lerp(defaultColor, other.defaultColor, t),
      secondary: Color.lerp(secondary, other.secondary, t),
      background: Color.lerp(background, other.background, t),
    );
  }
}
