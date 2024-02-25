import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/domain/utils/base_state_extensions.dart';
import 'package:photopulse/common/domain/utils/form_key_extensions.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_text_button.dart';
import 'package:photopulse/common/presentation/photo_pulse_text_form_field.dart';
import 'package:photopulse/common/presentation/photo_pulse_toast.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/features/profile/domain/notifiers/change_password_notifier.dart';
import 'package:photopulse/features/profile/forms/change_password_form_config.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:photopulse/theme/app_colors.dart';
import 'package:q_architecture/base_state_notifier.dart';

final passwordToMatch = StateProvider.autoDispose<String?>((_) => null);

class ChangePasswordDialog extends HookConsumerWidget {
  ChangePasswordDialog({super.key});

  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final password = ref.watch(passwordToMatch);

    ref.listen<BaseState<void>>(
      changePasswordNotifierProvider,
      (_, next) async {
        return switch (next) {
          BaseData() => {
              ref.pop(),
              PhotoPulseToast(
                message: S.current.password_changed,
              ).show(context),
            },
          BaseError(failure: final failure) => PhotoPulseToast(
              message: failure.title,
            ).show(context),
          _ => null,
        };
      },
    );

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
                  Icons.lock_rounded,
                  color: AppColors.black,
                ),
                const Gap(AppSizes.compactSpacing),
                HeadlineText(
                  S.current.change_password,
                  isBold: true,
                ),
              ],
            ),
            const Gap(AppSizes.mediumSpacing),
            FormBuilder(
              key: formKey,
              onChanged: () => refreshMatchingPasswords(ref),
              child: Column(
                children: [
                  PhotoPulseTextFormField.passwordTextField(
                    name: ChangePasswordFormConfig.oldPasswordKey,
                    labelText: S.current.old_password,
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.normalSpacing,
                  ),
                  PhotoPulseTextFormField.passwordTextField(
                    name: ChangePasswordFormConfig.newPasswordKey,
                    labelText: S.current.new_password,
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.normalSpacing,
                  ),
                  PhotoPulseTextFormField.passwordTextField(
                    name: ChangePasswordFormConfig.repeatedPasswordKey,
                    labelText: S.current.confirm_new_password,
                    validators: [
                      ChangePasswordFormConfig.passwordMatch(
                        password: password,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.normalSpacing,
                  ),
                ],
              ),
            ),
            const Gap(AppSizes.normalSpacing),
            PhotoPulseButton.primary(
              label: S.current.change_password,
              onTap: () {
                refreshMatchingPasswords(ref);
                formKey.submitForm(
                  (formMap) {
                    ref
                        .read(changePasswordNotifierProvider.notifier)
                        .changePassword(formMap);
                  },
                );
                FocusManager.instance.primaryFocus?.unfocus();
              },
              isLoading: ref.watch(changePasswordNotifierProvider).isLoading,
            ),
            const Gap(AppSizes.compactSpacing),
            PhotoPulseTextButton(
              label: S.current.cancel,
              onTap: ref.pop,
            ),
          ],
        ),
      ),
    );
  }

  void refreshMatchingPasswords(WidgetRef ref) =>
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          ref.read(passwordToMatch.notifier).state = formKey
              .currentState?.value[ChangePasswordFormConfig.newPasswordKey];
        },
      );
}
