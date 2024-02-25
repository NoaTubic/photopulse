import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/body_text.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:photopulse/theme/app_colors.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.mediumSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              indent: AppSizes.tinySpacing,
              endIndent: AppSizes.compactSpacing,
              thickness: 1,
              color: AppColors.black,
            ),
          ),
          BodyText(S.current.or.toUpperCase()),
          Expanded(
            child: Divider(
              indent: AppSizes.tinySpacing,
              endIndent: AppSizes.compactSpacing,
              thickness: AppSizes.dividerHeight,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
