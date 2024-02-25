import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/common/presentation/user_avatar.dart';
import 'package:photopulse/features/auth/domain/entities/user.dart';
import 'package:photopulse/features/feed/domain/notifiers/filters_notifier.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:photopulse/theme/app_colors.dart';

class UserDropdown extends ConsumerWidget {
  const UserDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(filtersNotifierProvider).users;
    return DropdownButtonFormField<PhotoPulseUser>(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.normalCircularRadius),
            borderSide: BorderSide(color: AppColors.black)),
      ),
      value: ref.watch(filtersNotifierProvider).selectedUser,
      hint: BodyText(
        S.current.select_user,
        isBold: true,
      ),
      onChanged: (PhotoPulseUser? user) =>
          ref.read(filtersNotifierProvider.notifier).changeUser(user),
      items: users.map<DropdownMenuItem<PhotoPulseUser>>((PhotoPulseUser user) {
        return DropdownMenuItem<PhotoPulseUser>(
          value: user,
          child: SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserAvatar(
                  user.photoUrl,
                  height: AppSizes.userDropdownAvatarSize,
                  width: AppSizes.userDropdownAvatarSize,
                ),
                const SizedBox(width: AppSizes.smallSpacing),
                Text(user.username),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
