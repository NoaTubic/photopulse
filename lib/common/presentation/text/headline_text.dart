import 'package:flutter/material.dart';
import 'package:photopulse/common/utils/build_context_extensions.dart';
import 'package:photopulse/theme/app_colors.dart';

class HeadlineText extends StatelessWidget {
  final String text;
  final Color? color;
  final bool isCentered;
  final bool isBold;
  final int? maxLines;
  final TextOverflow? textOverflow;

  const HeadlineText(
    this.text, {
    super.key,
    this.isCentered = false,
    this.isBold = false,
    this.color,
    this.textOverflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.headlineMedium?.copyWith(
        color: color ?? AppColors.black,
        fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
        overflow: textOverflow,
      ),
      textAlign: isCentered ? TextAlign.center : null,
      maxLines: maxLines,
    );
  }
}
