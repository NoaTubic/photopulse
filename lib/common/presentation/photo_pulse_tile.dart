import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/body_text.dart';
import 'package:photopulse/theme/app_colors.dart';

class PhotoPulseTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const PhotoPulseTile({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: AppSizes.normalCircularBorderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppSizes.normalCircularRadius,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(AppSizes.normalSpacing),
          decoration: BoxDecoration(
            borderRadius: AppSizes.normalCircularBorderRadius,
            border: Border.all(
              color: AppColors.primaryLight.withOpacity(0.7),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
              ),
              const Gap(AppSizes.normalSpacing),
              BodyText(
                label,
                isBold: true,
              ),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_right_rounded),
              const Gap(AppSizes.smallSpacing),
            ],
          ),
        ),
      ),
    );
  }
}
