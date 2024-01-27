import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/text.dart';

class SubscriptionPackageCardTextRow extends StatelessWidget {
  final String label;
  final String value;
  const SubscriptionPackageCardTextRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.compactSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BodyText(
            label,
          ),
          const Gap(AppSizes.smallSpacing),
          BodyText(
            value,
            isBold: true,
            isCentered: true,
          ),
        ],
      ),
    );
  }
}
