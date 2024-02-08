import 'package:flutter/material.dart';
import 'package:photopulse/theme/app_colors.dart';

class CustomDivider extends StatelessWidget {
  final Color? color;

  const CustomDivider({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1,
      height: 1,
      color: color ?? AppColors.accentDark,
    );
  }
}
