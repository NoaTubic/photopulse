import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/theme/app_colors.dart';

class CustomDivider extends StatelessWidget {
  final Color? color;

  const CustomDivider({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: AppSizes.dividerHeight,
      height: AppSizes.dividerHeight,
      color: color ?? AppColors.accentDark,
    );
  }
}
