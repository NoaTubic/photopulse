import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/build_context_extensions.dart';
import 'package:photopulse/theme/theme.dart';

class TitleText extends StatelessWidget {
  final String text;
  final Color? color;
  final bool isCentered;
  final bool isBold;
  final double? fontSize;

  const TitleText(
    this.text, {
    Key? key,
    this.isCentered = false,
    this.isBold = true,
    this.color,
    this.fontSize = FontSizes.s28,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.titleMedium?.copyWith(
        color: color,
        fontWeight: isBold ? FontWeight.w700 : null,
        fontSize: fontSize,
      ),
      textAlign: isCentered ? TextAlign.center : null,
    );
  }
}