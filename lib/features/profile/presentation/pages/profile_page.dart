import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
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
import 'package:photopulse/features/admin/presentation/pages/admin_page.dart';
import 'package:photopulse/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:photopulse/features/auth/domain/notifiers/user_notifier.dart';
import 'package:photopulse/features/profile/presentation/widgets/change_password_dialog.dart';
import 'package:photopulse/features/profile/presentation/widgets/change_user_info_dialog.dart';
import 'package:photopulse/features/subscription_management/presentation/widgets/current_subscription_section.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:photopulse/theme/app_colors.dart';

class ProfilePage extends ConsumerWidget {
  static const routeName = Pages.profile;

  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final isAnonymousUser = ref.watch(isAnonymousProvider);

    return PhotoPulseScaffold(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.bodyPaddingHorizontal, vertical: AppSizes.zero),
      body: Center(
        child: isAnonymousUser
            ? AnimatedColumn(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    const SizedBox(height: AppSizes.normalSpacing),
                    const Center(
                      child: HeadlineText(
                        'Please login or register to acesss all profile features',
                        isBold: true,
                        isCentered: true,
                      ),
                    ),
                    const SizedBox(height: AppSizes.largeSpacing),
                    PhotoPulseTile(
                      label: S.current.theme,
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
                      label: S.current.language,
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
                      onTap: () =>
                          ref.read(authNotifierProvider.notifier).logout(),
                      child: BodyText(
                        S.current.logout,
                        color: AppColors.white,
                        isBold: true,
                      ),
                    ),
                    const SizedBox(height: AppSizes.mediumSpacing),
                    Center(
                      child: PhotoPulseTextButton(
                        onTap: () {},
                        label: S.current.privacy_policy,
                      ),
                    ),
                  ])
            : SingleChildScrollView(
                child: AnimatedColumn(
                  children: [
                    // if (user?.isAdmin ?? false)
                    Align(
                      alignment: Alignment.topRight,
                      child: PhotoPulseTextButton(
                        onTap: () => ref.pushNamed(
                            '${ProfilePage.routeName}${AdminPage.routeName}'),
                        label: S.current.admin_panel,
                        textColor: AppColors.black,
                      ),
                    ),
                    UserAvatar(
                      user?.photoUrl,
                      width: AppSizes.largeAvatarRadius,
                    ),
                    const SizedBox(height: AppSizes.normalSpacing),
                    Column(
                      children: [
                        PhotoPulseTile(
                          label: user?.username ?? '',
                          icon: Icons.person_rounded,
                          action: PhotoPulseTextButton(
                            onTap: () => showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  ChangeUserInfoDialog.username(),
                            ),
                            label: S.current.change_username,
                          ),
                        ),
                        const SizedBox(height: AppSizes.normalSpacing),
                        PhotoPulseTile(
                          label: user?.email ?? '',
                          icon: Icons.email_rounded,
                          action: PhotoPulseTextButton(
                            onTap: () => showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  ChangeUserInfoDialog.email(),
                            ),
                            label: S.current.change_email,
                          ),
                        ),
                        const SizedBox(height: AppSizes.normalSpacing),
                        PhotoPulseExpansionTile(
                          title: S.current.subscription_package,
                          leadingIcon: Icons.edit_calendar_outlined,
                          children: const [
                            CurrentSubscriptionSection(),
                          ],
                        ),
                        const SizedBox(height: AppSizes.normalSpacing),
                        PhotoPulseTile(
                          label: 'Change password',
                          icon: Icons.lock_rounded,
                          action: GestureDetector(
                            onTap: () => showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  ChangePasswordDialog(),
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.normalSpacing),
                        PhotoPulseTile(
                          label: S.current.theme,
                          icon: Icons.contrast_rounded,
                          action: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(100),
                              color: AppColors.white,
                            ),
                            height: 40,
                            child: CupertinoSwitch(
                              thumbColor: AppColors.black,
                              activeColor: AppColors.black.withOpacity(0.07),
                              value: true,
                              onChanged: (_) {},
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.normalSpacing),
                        PhotoPulseTile(
                          label: S.current.language,
                          icon: Icons.language_rounded,
                          action: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.normalSpacing),
                    PhotoPulseButton.primary(
                      onTap: () =>
                          ref.read(authNotifierProvider.notifier).logout(),
                      child: BodyText(
                        S.current.logout,
                        color: AppColors.white,
                        isBold: true,
                      ),
                    ),
                    const SizedBox(height: AppSizes.normalSpacing),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PhotoPulseTextButton(
                            onTap: () {},
                            label: S.current.delete_account,
                            textColor: AppColors.alertCritical),
                        PhotoPulseTextButton(
                          onTap: () {},
                          label: S.current.privacy_policy,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
