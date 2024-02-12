import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/providers/base_router_provider.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/photo_pulse_app_bar.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/common/presentation/photo_pulse_toast.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/features/auth/domain/notifiers/user_notifier.dart';
import 'package:photopulse/features/subscription_management/domain/notifiers/subscription_management_notifier.dart';
import 'package:photopulse/features/subscription_management/presentation/widgets/subscription_package_slider.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:q_architecture/base_state_notifier.dart';

class SubscriptionManagementPage extends ConsumerWidget {
  static const routeName = Pages.subscriptionManagement;
  const SubscriptionManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<BaseState<void>>(
      subscriptionManagementNotifierProvider,
      (_, next) async {
        return switch (next) {
          BaseData() =>
            GoRouter.of(context).canPop() ? ref.pop() : ref.pushNamed('/'),
          BaseError() => PhotoPulseToast(
              message: S.current.error_message_something_wrong,
            ).show(rootNavigatorKey.currentState!.context),
          BaseLoading() => null,
          _ => Object(),
        };
      },
    );

    return PhotoPulseScaffold(
      appBar: ref.watch(userProvider)!.isFirstLogin
          ? null
          : PhotoPulseAppBar.withBackNav(onTap: () => ref.pop()),
      padding: EdgeInsets.zero,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeadlineText(S.current.headline_choose_prescription_package),
            const Gap(AppSizes.xLargeSpacing),
            const SubscriptionPackageSlider(),
            const Gap(AppSizes.xLargeSpacing),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSizes.xLargeSpacing,
              ),
              child: PhotoPulseButton.primary(
                onTap: () => ref
                    .read(subscriptionManagementNotifierProvider.notifier)
                    .updateUserSubscriptionPackage(),
                label: S.current.button_label_choose_package,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
