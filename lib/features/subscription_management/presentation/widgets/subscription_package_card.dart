import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/features/subscription_management/domain/entities/subscription_package.dart';
import 'package:photopulse/features/subscription_management/domain/notifiers/subscription_management_notifier.dart';
import 'package:photopulse/features/subscription_management/presentation/widgets/subscription_package_card_text_row.dart';
import 'package:photopulse/theme/app_colors.dart';
import 'package:photopulse/features/subscription_management/presentation/widgets/animated_tick.dart';

class SubscriptionPackageCard extends ConsumerWidget {
  final SubscriptionPackage subscription;
  final VoidCallback onTap;

  const SubscriptionPackageCard({
    super.key,
    required this.subscription,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.smallSpacing,
      ),
      child: Material(
        color: AppColors.primaryLight.withOpacity(0.5),
        borderRadius: AppSizes.normalCircularBorderRadius,
        child: InkWell(
          splashColor: AppColors.primaryLight.withOpacity(0.3),
          highlightColor: AppColors.primaryLight.withOpacity(0.3),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: AppSizes.normalCircularBorderRadius,
              border: Border.all(
                color: subscription ==
                        ref.watch(
                          selectedSubscriptionPackageProvider,
                        )
                    ? AppColors.primaryDefault
                    : AppColors.primaryDefault.withOpacity(0.5),
                width: subscription ==
                        ref.watch(
                          selectedSubscriptionPackageProvider,
                        )
                    ? 4
                    : 2,
              ),
            ),
            width: 280,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    subscription.iconPath,
                    width: 100,
                    height: 100,
                    color: AppColors.primaryDefault.withOpacity(0.5),
                  ),
                  TitleText(
                    subscription.name.toUpperCase(),
                  ),
                  const Gap(AppSizes.normalSpacing),
                  SubscriptionPackageCardTextRow(
                    label: 'Upload size:',
                    value: subscription.uploadSizeLimit.toString(),
                  ),
                  SubscriptionPackageCardTextRow(
                    label: 'Daily Upload Limit:',
                    value: subscription.dailyUploadLimit.toString(),
                  ),
                  SubscriptionPackageCardTextRow(
                    label: 'Maximum spend:',
                    value: subscription.maxSpend.toString(),
                  ),
                  AnimatedTick(
                    isChecked: subscription ==
                        ref.watch(
                          selectedSubscriptionPackageProvider,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
