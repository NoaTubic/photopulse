import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:photopulse/theme/app_colors.dart';

class FeedError extends StatelessWidget {
  const FeedError({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_rounded,
          size: AppSizes.iconMediumSize,
          color: AppColors.black,
        ),
        const SizedBox(width: AppSizes.smallSpacing),
        BodyText(
          S.current.error_message_something_wrong,
          isBold: true,
        ),
      ],
    );
  }
}
