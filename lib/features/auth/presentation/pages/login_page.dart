// ignore_for_file: always_use_package_imports, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:photopulse/common/presentation/build_context_extensions.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/common_validators.dart';
import 'package:photopulse/common/presentation/image_assets.dart';
import 'package:photopulse/common/presentation/or_divider.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_text_button.dart';
import 'package:photopulse/common/presentation/photo_pulse_text_form_field.dart';
import 'package:photopulse/common/presentation/photo_pulse_toast.dart';
import 'package:photopulse/common/presentation/text/display_text.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:photopulse/features/auth/domain/notifiers/auth_state.dart';
import 'package:photopulse/features/auth/domain/notifiers/login_notifier.dart';
import 'package:photopulse/features/auth/domain/notifiers/user_notifier.dart';
import 'package:photopulse/features/auth/forms/login_form_config.dart';
import 'package:photopulse/features/auth/presentation/pages/registration_page.dart';
import 'package:photopulse/features/auth/presentation/widgets/social_login_section.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:photopulse/theme/app_colors.dart';
import 'package:photopulse/theme/theme.dart';
import 'package:q_architecture/base_state_notifier.dart';

final formKey = GlobalKey<FormBuilderState>();

class LoginPage extends ConsumerWidget {
  static const routeName = '/login';

  const LoginPage({super.key});

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
    return PhotoPulseScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Gap(
              AppSizes.mediumSpacing,
            ),
            Image.asset(
              ImageAssets.logo,
              height: context.isLargerThanMobile
                  ? AppSizes.appLogoWeb
                  : AppSizes.appLogo,
            ),
            const Gap(
              AppSizes.smallSpacing,
            ),
            DisplayText(
              S.current.photo_pulse,
              color: AppColors.primaryDefault,
              fontSize:
                  context.isLargerThanMobile ? FontSizes.s30 : FontSizes.s24,
              fontFamily: 'Cocogoose Pro',
            ),
            const Gap(
              AppSizes.mediumSpacing,
            ),
            FormBuilder(
              key: formKey,
              onChanged: () => refreshNextEnabled(
                formKey: formKey,
                isFormSubmissionEnabledProvider:
                    isFormSubmissionEnabledProvider,
                ref: ref,
                formIdentifier: Pages.login,
              ),
              child: Column(
                children: [
                  PhotoPulseTextFormField.normalTextField(
                    textInputType: TextInputType.emailAddress,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    name: LoginFormConfig.emailKey,
                    validators: [
                      CommonValidators.email(),
                      CommonValidators.requiredEmail(),
                    ],
                    labelText: S.current.email,
                  ),
                  PhotoPulseTextFormField.passwordTextField(
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    name: LoginFormConfig.passwordKey,
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    labelText: S.current.password,
                  ),
                  const Gap(
                    AppSizes.normalSpacing,
                  ),
                  PhotoPulseButton.primary(
                    label: S.current.login,
                    onTap: () => formKey.submitForm(
                      (formMap) => loginNotifier.login(formMap),
                    ),
                    isEnabled:
                        ref.watch(isFormSubmissionEnabledProvider(Pages.login)),
                    isLoading: loginState.isLoading,
                  ),
                  const Gap(
                    AppSizes.compactSpacing,
                  ),
                  PhotoPulseTextButton(
                    onTap: () {},
                    label: S.current.forgot_password,
                  ),
                  Gap(
                    MediaQuery.of(context).size.height * 0.05,
                  ),
                  PhotoPulseButton.secondary(
                    label: S.current.create_new_account,
                    onTap: () => ref.pushNamed(
                      '$routeName${RegistrationPage.routeName}',
                    ),
                  ),
                  const OrDivider(),
                  const SocialLoginSection(),
                  const Gap(
                    AppSizes.largeSpacing,
                  ),
                  PhotoPulseTextButton(
                    onTap: () => FirebaseAuth.instance.signOut(),
                    // loginNotifier.loginAnonymously(),
                    label: S.current.anonymous_login,
                  ),
                  const Gap(
                    AppSizes.mediumSpacing,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
