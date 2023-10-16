import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/build_context_extensions.dart';

class LabelText extends StatelessWidget {
  final String text;
  final Color? color;
  final bool isCentered;
  final bool isBold;

  const LabelText(
    this.text, {
    Key? key,
    this.isCentered = false,
    this.isBold = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.labelMedium?.copyWith(
        color: color,
        fontWeight: isBold ? FontWeight.w700 : null,
      ),
      textAlign: isCentered ? TextAlign.center : null,
    );
  }
}
