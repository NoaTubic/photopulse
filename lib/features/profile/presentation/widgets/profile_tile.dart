import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/theme/app_colors.dart';

class MyProfileTile extends StatelessWidget {
  final String labelText;
  final Widget content;
  final VoidCallback onTap;
  final IconData icon;

  const MyProfileTile({
    super.key,
    required this.labelText,
    required this.content,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.normalSpacing),
      child: Material(
        color: AppColors.white,
        borderRadius: AppSizes.normalCircularBorderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.all(
            Radius.circular(AppSizes.normalCircularRadius),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.normalSpacing,
              horizontal: AppSizes.compactSpacing,
            ),
            decoration: const BoxDecoration(
              borderRadius: AppSizes.normalCircularBorderRadius,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon),
                const Gap(AppSizes.normalSpacing),
                BodyText(
                  labelText,
                  isBold: true,
                ),
                const Spacer(),
                content,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
