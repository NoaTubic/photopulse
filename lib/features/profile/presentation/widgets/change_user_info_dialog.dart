import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/domain/utils/base_state_extensions.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_text_button.dart';

import 'package:photopulse/common/presentation/photo_pulse_text_form_field.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/features/admin/domain/notifiers/users_notifier.dart';
import 'package:photopulse/features/auth/domain/notifiers/user_data_notifier.dart';
import 'package:photopulse/features/auth/domain/notifiers/user_notifier.dart';
import 'package:photopulse/theme/app_colors.dart';

final formKey = GlobalKey<FormBuilderState>();

enum UserInfoType { email, username }

class ChangeUserInfoDialog extends HookConsumerWidget {
  final UserInfoType type;

  const ChangeUserInfoDialog._({super.key, required this.type});

  factory ChangeUserInfoDialog.email({Key? key}) {
    return ChangeUserInfoDialog._(key: key, type: UserInfoType.email);
  }

  factory ChangeUserInfoDialog.username({Key? key}) {
    return ChangeUserInfoDialog._(key: key, type: UserInfoType.username);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final String title =
        type == UserInfoType.email ? 'Change Email' : 'Change Username';
    final String hintText =
        type == UserInfoType.email ? 'New Email' : 'New Username';
    final List<String? Function(String?)> validators =
        type == UserInfoType.email
            ? [
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
              ]
            : [FormBuilderValidators.required()];
    final user = ref.watch(userProvider);

    return Dialog(
      insetPadding: const EdgeInsets.all(AppSizes.normalSpacing),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.mediumSpacing),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.normalCircularRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  type == UserInfoType.email
                      ? Icons.email_rounded
                      : Icons.person_rounded,
                  color: AppColors.black,
                ),
                const Gap(AppSizes.compactSpacing),
                HeadlineText(
                  title,
                  isBold: true,
                ),
              ],
            ),
            const Gap(AppSizes.mediumSpacing),
            FormBuilder(
              key: formKey,
              child: PhotoPulseTextFormField.normalTextField(
                controller: controller,
                name: '',
                labelText: hintText,
                validators: validators,
              ),
            ),
            const Gap(AppSizes.mediumSpacing),
            PhotoPulseButton.primary(
              label: 'Update',
              onTap: () {
                if (formKey.currentState?.saveAndValidate() ?? false) {
                  type == UserInfoType.email
                      ? ref.read(userDataNotifierProvider.notifier).changeEmail(
                            controller.text,
                          )
                      : ref
                          .read(userDataNotifierProvider.notifier)
                          .changeUsername(
                            username: controller.text,
                            userId: (user?.isAdmin ?? false) ? user!.id : null,
                          );
                  ref.pop();
                }
              },
              isLoading: ref.watch(userDataNotifierProvider).isLoading,
            ),
            const Gap(AppSizes.compactSpacing),
            PhotoPulseTextButton(
              label: 'Cancel',
              onTap: ref.pop,
            ),
          ],
        ),
      ),
    );
  }
}
