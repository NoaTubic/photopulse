import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/presentation/animated_widgets/animated_column.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_text_button.dart';
import 'package:photopulse/common/presentation/photo_pulse_expansion_tile.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/common/presentation/photo_pulse_tile.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/common/presentation/user_avatar.dart';
import 'package:photopulse/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:photopulse/features/auth/domain/notifiers/user_notifier.dart';
import 'package:photopulse/features/subscription_management/presentation/widgets/current_subscription_section.dart';
import 'package:photopulse/theme/app_colors.dart';

class ProfilePage extends ConsumerWidget {
  static const routeName = Pages.profile;

  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return PhotoPulseScaffold(
      body: Center(
        child: SingleChildScrollView(
          child: AnimatedColumn(
            children: [
              UserAvatar(
                user?.photoUrl,
                width: AppSizes.largeAvatarRadius,
              ),
              const SizedBox(height: AppSizes.mediumSpacing),
              PhotoPulseTile(
                label: user?.username ?? '',
                icon: Icons.person_rounded,
                action: const BodyText('Change username'),
              ),
              const SizedBox(height: AppSizes.normalSpacing),
              PhotoPulseTile(
                label: user?.email ?? '',
                icon: Icons.email_rounded,
                action: const BodyText('Change email'),
              ),
              const SizedBox(height: AppSizes.normalSpacing),
              const PhotoPulseExpansionTile(
                title: 'Subscription Package',
                leadingIcon: Icons.edit_calendar_outlined,
                children: [
                  CurrentSubscriptionSection(),
                ],
              ),
              const SizedBox(height: AppSizes.normalSpacing),
              PhotoPulseTile(
                label: 'Theme',
                icon: Icons.contrast_rounded,
                action: SizedBox(
                  height: 20,
                  child: CupertinoSwitch(
                    value: true,
                    onChanged: (_) {},
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.normalSpacing),
              PhotoPulseTile(
                label: 'Language',
                icon: Icons.language_rounded,
                action: SizedBox(
                  height: 20,
                  child: CupertinoSwitch(
                    value: true,
                    onChanged: (_) {},
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.largeSpacing),
              PhotoPulseButton.primary(
                onTap: () => ref.read(authNotifierProvider.notifier).logout(),
                child: const Text('Logout'),
              ),
              const SizedBox(height: AppSizes.mediumSpacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PhotoPulseTextButton(
                      onTap: () {},
                      label: 'Delete Account',
                      textColor: AppColors.alertCritical),
                  PhotoPulseTextButton(onTap: () {}, label: 'Privacy Policy'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
