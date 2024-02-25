import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/text/body_text.dart';
import 'package:photopulse/common/presentation/text/headline_text.dart';
import 'package:photopulse/common/utils/double_extensions.dart';
import 'package:photopulse/features/auth/domain/entities/user.dart';
import 'package:photopulse/features/auth/domain/notifiers/user_data_notifier.dart';
import 'package:photopulse/features/subscription_management/domain/entities/subscription_package.dart';
import 'package:photopulse/features/subscription_management/domain/notifiers/subscription_management_notifier.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:photopulse/theme/app_colors.dart';

class UserTile extends ConsumerWidget {
  final PhotoPulseUser user;

  const UserTile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionPackage = SubscriptionPackage.values
        .where((subscription) => subscription == (user.subscriptionPackage!))
        .first;
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppSizes.normalCircularBorderRadius,
        border: Border.all(
          color: AppColors.black,
        ),
      ),
      child: ClipRRect(
        borderRadius: AppSizes.normalCircularBorderRadius,
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: Card(
            color: AppColors.white,
            elevation: 0,
            child: ExpansionTile(
              shape: const RoundedRectangleBorder(
                borderRadius: AppSizes.normalCircularBorderRadius,
              ),
              collapsedBackgroundColor: AppColors.white,
              backgroundColor: AppColors.white,
              leading: user.photoUrl!.isNotEmpty
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(user.photoUrl!),
                    )
                  : CircleAvatar(
                      backgroundColor: AppColors.black.withOpacity(0.15),
                      child: Icon(
                        Icons.person,
                        color: AppColors.black,
                      ),
                    ),
              title: BodyText(
                user.username,
                isBold: true,
              ),
              subtitle: BodyText(
                user.email,
                isBold: true,
              ),
              children: [
                ListTile(
                  title: BodyText(S.current.id),
                  subtitle: BodyText(
                    user.id,
                    isBold: true,
                  ),
                ),
                ListTile(
                  title: BodyText(S.current.subscription_package),
                  trailing: Image.asset(
                    user.subscriptionPackage?.iconPath ?? '',
                    color: AppColors.black,
                    width: AppSizes.iconLargeSize,
                  ),
                  subtitle: BodyText(
                    user.subscriptionPackage?.name.toUpperCase() ??
                        S.current.none,
                    isBold: true,
                  ),
                  onTap: () => _showSubscriptionOptions(context, user.id, ref),
                ),
                ListTile(
                  title: BodyText(S.current.daily_uploads),
                  subtitle: BodyText(
                    '${user.dailyUploads} / ${subscriptionPackage.dailyUploadLimit}',
                    isBold: true,
                  ),
                ),
                ListTile(
                  title: BodyText(S.current.total_size_uploaded),
                  subtitle: BodyText(
                    '${user.totalUploadSizeInMB.rounded(2)} MB',
                    isBold: true,
                  ),
                ),
                ListTile(
                  title: BodyText(S.current.max_spend),
                  subtitle: BodyText(
                    '\$${user.maxSpend} / \$${subscriptionPackage.maxSpend}',
                    isBold: true,
                  ),
                ),
                ListTile(
                  title: BodyText(S.current.is_admin),
                  subtitle: BodyText(
                    user.isAdmin ?? false ? S.current.yes : S.current.no,
                    isBold: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.xLargeSpacing),
                  child: PhotoPulseButton.primary(
                      onTap: () => ref
                          .read(userDataNotifierProvider.notifier)
                          .clearStatistics(user.id),
                      label: S.current.clear_statistics),
                ),
                const Gap(AppSizes.normalSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showSubscriptionOptions(
    BuildContext context, String userId, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppSizes.normalCircularRadius),
            topRight: Radius.circular(AppSizes.normalCircularRadius),
          ),
          color: AppColors.white,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(AppSizes.tinySpacing),
              GestureDetector(
                onTap: ref.pop,
                child: const Icon(Icons.drag_handle_rounded),
              ),
              const Gap(AppSizes.normalSpacing),
              HeadlineText(S.current.change_subscription),
              Padding(
                padding: const EdgeInsets.all(AppSizes.normalSpacing),
                child: Wrap(
                  children: SubscriptionPackage.values.map(
                    (subscription) {
                      return ListTile(
                        leading: Image.asset(
                          subscription.iconPath,
                          color: AppColors.black,
                          width: AppSizes.iconLargeSize,
                        ),
                        title: BodyText(
                          subscription.name.toUpperCase(),
                          isBold: true,
                        ),
                        onTap: () {
                          ref
                              .read(
                                  selectedSubscriptionPackageProvider.notifier)
                              .state = subscription;
                          ref
                              .read(subscriptionManagementNotifierProvider
                                  .notifier)
                              .updateUserSubscriptionPackage(id: userId);
                          ref.pop();
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
