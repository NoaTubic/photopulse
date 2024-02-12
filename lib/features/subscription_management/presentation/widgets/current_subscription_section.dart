import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/photo_pulse_toast.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/features/auth/domain/notifiers/user_notifier.dart';
import 'package:photopulse/features/subscription_management/domain/entities/subscription_package.dart';
import 'package:photopulse/features/subscription_management/presentation/pages/subscription_management_page.dart';
import 'package:photopulse/features/subscription_management/presentation/widgets/subscription_package_card_text_row.dart';
import 'package:photopulse/features/upload_content/presentation/pages/upload_content_page.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:photopulse/theme/app_colors.dart';
import 'package:photopulse/theme/theme.dart';

class CurrentSubscriptionSection extends ConsumerWidget {
  const CurrentSubscriptionSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final subscriptionPackage = SubscriptionPackage.values
        .where((subscription) => subscription == (user?.subscriptionPackage!))
        .first;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              subscriptionPackage.iconPath,
              width: AppSizes.iconMediumSize,
              color: AppColors.black,
            ),
            const Gap(AppSizes.smallSpacing),
            BodyText(
              subscriptionPackage.name.toUpperCase(),
              isBold: true,
              fontSize: FontSizes.s18,
            ),
          ],
        ),
        const Gap(AppSizes.compactSpacing),
        SubscriptionPackageCardTextRow(
          label: S.current.upload_size,
          value: '${subscriptionPackage.uploadSizeLimit.toString()} MB',
        ),
        SubscriptionPackageCardTextRow(
          label: S.current.uploaded_today,
          value:
              '${user!.dailyUploads} / ${subscriptionPackage.dailyUploadLimit}',
        ),
        SubscriptionPackageCardTextRow(
          label: S.current.max_spend,
          value: '${user.maxSpend} / ${subscriptionPackage.maxSpend}',
        ),
        const Gap(AppSizes.tinySpacing),
        Divider(
          color: AppColors.black,
          height: 0,
          thickness: 0.5,
          endIndent: AppSizes.compactSpacing,
          indent: AppSizes.compactSpacing,
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: user.canChangeSubscription
                ? () => ref.pushNamed(
                      '${UploadContentPage.routeName}${SubscriptionManagementPage.routeName}',
                    )
                : () => PhotoPulseToast(
                        message: S.current.change_subscription_error)
                    .show(context),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.compactSpacing,
                ),
                child: BodyText(
                  S.current.change_subscription,
                  isBold: true,
                  isCentered: true,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
