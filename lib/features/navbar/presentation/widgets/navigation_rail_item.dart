import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/title_text.dart';
import 'package:photopulse/theme/app_colors.dart';

class NavigationRailItem extends StatelessWidget {
  const NavigationRailItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.isSelected,
  }) : super(key: key);

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
          // SvgPicture.asset(
          //   iconPath,
          //   colorFilter: ColorFilter.mode(
          //     isSelected ? AppColors.primaryDark : AppColors.greyDark30,
          //     BlendMode.srcIn,
          //   ),
          // ),
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
