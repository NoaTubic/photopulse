// ignore_for_file: always_use_package_imports, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/domain/utils/base_state_extensions.dart';
import 'package:photopulse/common/domain/utils/form_key_extensions.dart';
import 'package:photopulse/common/presentation/animated_widgets/animated_column.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/common_validators.dart';
import 'package:photopulse/common/presentation/or_divider.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_text_button.dart';
import 'package:photopulse/common/presentation/photo_pulse_text_form_field.dart';
import 'package:photopulse/common/presentation/photo_pulse_toast.dart';
import 'package:photopulse/features/auth/domain/notifiers/account_recovery_notifier.dart';
import 'package:photopulse/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:photopulse/features/auth/domain/notifiers/auth_state.dart';
import 'package:photopulse/features/auth/domain/notifiers/login_notifier.dart';
import 'package:photopulse/features/auth/domain/notifiers/user_notifier.dart';
import 'package:photopulse/features/auth/forms/login_form_config.dart';
import 'package:photopulse/features/auth/presentation/pages/registration_page.dart';
import 'package:photopulse/features/auth/presentation/pages/reset_password_page.dart';
import 'package:photopulse/features/auth/presentation/widgets/animated_logo.dart';
import 'package:photopulse/features/auth/presentation/widgets/social_login_section.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:q_architecture/base_state_notifier.dart';

class LoginPage extends HookConsumerWidget {
  static const routeName = Pages.login;

  LoginPage({super.key});

  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginNotifierProvider);
    final loginNotifier = ref.read(loginNotifierProvider.notifier);
    ref.watch(authNotifierProvider.notifier).listenAuthChanges();

    ref.listen<BaseState<void>>(
      loginNotifierProvider,
      (_, next) async {
        return switch (next) {
          BaseData() => {
              await ref.read(userProvider.notifier).getUser(),
              if (ref.read(authNotifierProvider) ==
                  const AuthState.authenticated())
                {
                  await ref.read(userProvider.notifier).getUser(),
                },
            },
          BaseError(failure: final failure) => PhotoPulseToast(
              message: failure.title,
            ).show(context),
          _ => Object(),
        };
      },
    );

    ref.listen<BaseState<void>>(
      accountRecoveryNotifierProvider,
      (_, next) async {
        return switch (next) {
          BaseData() => PhotoPulseToast(
              message: S.current.password_reset_email_sent,
            ).show(context),
          BaseError(failure: final failure) => PhotoPulseToast(
              message: failure.title,
            ).show(context),
          _ => Object(),
        };
      },
    );

    return PhotoPulseScaffold(
      body: Center(
        child: SingleChildScrollView(
          child: AnimatedColumn(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AnimatedLogo(),
              const SizedBox(height: AppSizes.normalSpacing),
              const SizedBox(height: AppSizes.mediumSpacing),
              FormBuilder(
                key: formKey,
                child: Column(
                  children: [
                    PhotoPulseTextFormField.normalTextField(
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      textInputType: TextInputType.emailAddress,
                      name: LoginFormConfig.emailKey,
                      validators: [
                        CommonValidators.email(),
                        CommonValidators.requiredEmail(),
                      ],
                      labelText: S.current.email,
                    ),
                    PhotoPulseTextFormField.passwordTextField(
                      name: LoginFormConfig.passwordKey,
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                      labelText: S.current.password,
                    ),
                    const SizedBox(
                      height: AppSizes.normalSpacing,
                    ),
                    PhotoPulseButton.primary(
                      label: S.current.login,
                      onTap: () => formKey.submitForm(
                        (formMap) => loginNotifier.login(formMap),
                      ),
                      isLoading: loginState.isLoading,
                    ),
                    const SizedBox(
                      height: AppSizes.compactSpacing,
                    ),
                    PhotoPulseTextButton(
                      onTap: () => ref.pushNamed(
                        '$routeName${ResetPasswordPage.routeName}',
                      ),
                      label: S.current.forgot_password,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    PhotoPulseButton.secondary(
                      label: S.current.create_new_account,
                      onTap: () => ref.pushNamed(
                        '$routeName${RegistrationPage.routeName}',
                      ),
                    ),
                    const SizedBox(
                      height: AppSizes.normalSpacing,
                    ),
                    const OrDivider(),
                    const SocialLoginSection(),
                    const SizedBox(
                      height: AppSizes.largeSpacing,
                    ),
                    PhotoPulseTextButton(
                      onTap: () => loginNotifier.loginAnonymously(),
                      label: S.current.anonymous_login,
                    ),
                    const SizedBox(
                      height: AppSizes.mediumSpacing,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
