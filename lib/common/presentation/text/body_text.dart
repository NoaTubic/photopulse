import 'package:flutter/material.dart';
import 'package:photopulse/common/utils/build_context_extensions.dart';
import 'package:photopulse/theme/app_colors.dart';

class BodyText extends StatelessWidget {
  final String text;
  final Color? color;
  final bool isCentered;
  final bool isUnderlined;
  final bool isBold;
  final TextOverflow? textOverflow;
  final double? fontSize;
  final int? maxLines;
  final TextAlign? textAlign;

  const BodyText(
    this.text, {
    super.key,
    this.isCentered = false,
    this.isBold = false,
    this.color,
    this.textOverflow,
    this.isUnderlined = false,
    this.fontSize,
    this.maxLines,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: context.bodyMedium?.copyWith(
        color: color ?? AppColors.black,
        fontWeight: isBold ? FontWeight.w700 : null,
        overflow: textOverflow,
        decoration: isUnderlined ? TextDecoration.underline : null,
        fontSize: fontSize,
      ),
      textAlign: isCentered ? TextAlign.center : textAlign,
    );
  }
}
