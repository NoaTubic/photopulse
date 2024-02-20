import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/title_text.dart';
import 'package:photopulse/theme/app_colors.dart';

class NavigationRailItem extends StatelessWidget {
  const NavigationRailItem({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
  });

  final Icon icon;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: AppSizes.navigationRailWidth / 2,
        right: AppSizes.normalSpacing,
        top: AppSizes.normalSpacing,
        bottom: AppSizes.normalSpacing,
      ),
      decoration: isSelected
          ? BoxDecoration(
              color: AppColors.white,
              border: Border(
                right: BorderSide(
                  color: AppColors.white,
                  width: AppSizes.tinySpacing,
                ),
              ),
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          const SizedBox(
            width: AppSizes.normalSpacing,
          ),
          TitleText(
            title,
            isBold: isSelected,
          ),
        ],
      ),
    );
  }
}
