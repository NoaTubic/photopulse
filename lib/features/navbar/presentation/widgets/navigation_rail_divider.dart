import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/theme/app_colors.dart';

class NavigationRailDivider extends StatelessWidget {
  const NavigationRailDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: const EdgeInsets.only(left: AppSizes.tinySpacing),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.white,
            blurRadius: 0,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: AppColors.white,
            blurRadius: AppSizes.tinySpacing,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: AppColors.white,
            blurRadius: AppSizes.normalSpacing,
            spreadRadius: 0,
          ),
        ],
      ),
    );
  }
}
