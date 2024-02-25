import 'package:flutter/material.dart';
import 'package:photopulse/theme/theme.dart';

abstract class TextStyles {
  static TextStyle light({
    double fontSize = FontSizes.s16,
    required Color color,
  }) {
    return _textStyle(
      fontSize,
      Fonts.fontFamily,
      FontWeights.light,
      color,
    );
  }

  static TextStyle medium({
    double fontSize = FontSizes.s16,
    required Color color,
  }) {
    return _textStyle(
      fontSize,
      Fonts.fontFamily,
      FontWeights.medium,
      color,
    );
  }

  static TextStyle regular({
    double fontSize = FontSizes.s16,
    required Color color,
  }) {
    return _textStyle(
      fontSize,
      Fonts.fontFamily,
      FontWeights.regular,
      color,
    );
  }

  static TextStyle semiBold({
    double fontSize = FontSizes.s16,
    required Color color,
  }) {
    return _textStyle(
      fontSize,
      Fonts.fontFamily,
      FontWeights.semiBold,
      color,
    );
  }

  static TextStyle bold({
    double fontSize = FontSizes.s16,
    required Color color,
  }) {
    return _textStyle(
      fontSize,
      Fonts.fontFamily,
      FontWeights.bold,
      color,
    );
  }

  static TextStyle _textStyle(
    double fontSize,
    String fontFamily,
    FontWeight fontWeight,
    Color color,
  ) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
