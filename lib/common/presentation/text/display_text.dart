import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/build_context_extensions.dart';

class DisplayText extends StatelessWidget {
  final String text;
  final Color? color;
  final bool isCentered;
  final bool isBold;
  final double? fontSize;
  final String? fontFamily;

  const DisplayText(
    this.text, {
    Key? key,
    this.isCentered = false,
    this.isBold = false,
    this.color,
    this.fontSize,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.displayMedium?.copyWith(
        color: color,
        fontWeight: isBold ? FontWeight.w700 : null,
        fontSize: fontSize,
        height: 1.5,
        fontFamily: fontFamily,
      ),
      textAlign: isCentered ? TextAlign.center : null,
    );
  }
}
