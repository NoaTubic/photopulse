import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/build_context_extensions.dart';

class BodyText extends StatelessWidget {
  final String text;
  final Color? color;
  final bool isCentered;
  final bool isUnderlined;
  final bool isBold;
  final TextOverflow? textOverflow;
  final double? fontSize;
  final int? maxLines;

  const BodyText(
    this.text, {
    Key? key,
    this.isCentered = false,
    this.isBold = false,
    this.color,
    this.textOverflow,
    this.isUnderlined = false,
    this.fontSize,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: context.bodyMedium?.copyWith(
        color: color,
        fontWeight: isBold ? FontWeight.w700 : null,
        overflow: textOverflow,
        decoration: isUnderlined ? TextDecoration.underline : null,
        fontSize: fontSize,
      ),
      textAlign: isCentered ? TextAlign.center : null,
    );
  }
}
