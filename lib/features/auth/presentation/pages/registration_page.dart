// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/providers/form_submission_enabled_provider.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/domain/utils/base_state_extensions.dart';
import 'package:photopulse/common/domain/utils/form_key_extensions.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/common_validators.dart';
import 'package:photopulse/common/presentation/photo_pulse_app_bar.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/common/presentation/photo_pulse_text_button.dart';
import 'package:photopulse/common/presentation/photo_pulse_text_form_field.dart';
import 'package:photopulse/common/presentation/photo_pulse_toast.dart';
import 'package:photopulse/features/auth/domain/notifiers/registration_notifier.dart';
import 'package:photopulse/features/auth/forms/registration_form_config.dart';
import 'package:photopulse/features/auth/presentation/pages/verify_email_page.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:q_architecture/base_state_notifier.dart';

final formKey = GlobalKey<FormBuilderState>();
final emailToVerifyProvider = StateProvider<String?>((_) => null);

class RegistrationPage extends ConsumerWidget {
  static const routeName = '/registration';

  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationState = ref.watch(registrationNotifierProvider);
    ref.listen<BaseState<void>>(
      registrationNotifierProvider,
      (_, next) {
        ref.read(emailToVerifyProvider.notifier).state = formKey
            .currentState?.fields[RegistrationFormConfig.emailKey]?.value;
        return switch (next) {
          BaseData() => ref.pushReplacementNamed(VerifyEmailPage.routeName),
          BaseError(failure: final failure) => PhotoPulseToast(
              message: failure.title,
            ).show(context),
          _ => Object(),
        };
      },
    );
    return PhotoPulseScaffold(
      appBar: PhotoPulseAppBar.withBackNav(
        title: S.current.create_new_account,
        onTap: ref.pop,
      ),
      body: Center(
        child: Column(
          children: [
            FormBuilder(
              key: formKey,
              onChanged: () => refreshNextEnabled(
                formKey: formKey,
                isFormSubmissionEnabledProvider:
                    isFormSubmissionEnabledProvider,
                ref: ref,
                formIdentifier: Pages.registration,
              ),
              child: Column(
                children: [
                  PhotoPulseTextFormField.normalTextField(
                    textInputType: TextInputType.emailAddress,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    name: RegistrationFormConfig.usernameKey,
                    labelText: S.current.username,
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  PhotoPulseTextFormField.normalTextField(
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    name: RegistrationFormConfig.emailKey,
                    labelText: S.current.email,
                    validators: [
                      CommonValidators.email(),
                      CommonValidators.requiredEmail(),
                    ],
                  ),
                  PhotoPulseTextFormField.passwordTextField(
                    name: RegistrationFormConfig.passwordKey,
                    labelText: S.current.password,
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  PhotoPulseTextFormField.passwordTextField(
                    autoValidateMode: AutovalidateMode.disabled,
                    name: RegistrationFormConfig.confirmPasswordKey,
                    labelText: S.current.confirm_password,
                    validators: [
                      CommonValidators.confirmPassword(
                        formKey,
                        RegistrationFormConfig.passwordKey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(
              AppSizes.normalSpacing,
            ),
            PhotoPulseButton.primary(
              label: S.current.create_new_account,
              onTap: () => formKey.submitForm(
                (formMap) => ref
                    .read(registrationNotifierProvider.notifier)
                    .register(formMap),
              ),
              isEnabled: ref
                  .watch(isFormSubmissionEnabledProvider(Pages.registration)),
              isLoading: registrationState.isLoading,
            ),
            const Gap(
              AppSizes.compactSpacing,
            ),
            PhotoPulseTextButton(
              onTap: ref.pop,
              label: S.current.go_back,
            ),
          ],
        ),
      ),
    );
  }
}
