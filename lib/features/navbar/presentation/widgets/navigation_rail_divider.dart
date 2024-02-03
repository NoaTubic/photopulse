import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/theme/app_colors.dart';

class NavigationRailDivider extends StatelessWidget {
  const NavigationRailDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: const EdgeInsets.only(left: AppSizes.tinySpacing),
      decoration: BoxDecoration(
        color: AppColors.greyDark30,
        boxShadow: [
          BoxShadow(
            color: AppColors.greyDark,
            blurRadius: 0,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: AppColors.greyDark,
            blurRadius: AppSizes.tinySpacing,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: AppColors.greyDark,
            blurRadius: AppSizes.normalSpacing,
            spreadRadius: 0,
          ),
        ],
      ),
    );
  }
}