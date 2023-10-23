// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/build_context_extensions.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/common_validators.dart';
import 'package:photopulse/common/presentation/image_assets.dart';
import 'package:photopulse/common/presentation/or_divider.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/common/presentation/photo_pulse_text__form_field.dart';
import 'package:photopulse/common/presentation/text/display_text.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/features/auth/forms/login_form_config.dart';
import 'package:photopulse/features/login/widgets/social_login_section.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:photopulse/theme/app_colors.dart';
import 'package:photopulse/theme/theme.dart';

final isNextEnabled = StateProvider.autoDispose<bool>((_) => false);
final formKey = GlobalKey<FormBuilderState>();

class LoginPage extends ConsumerWidget {
  static const routeName = '/login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PhotoPulseScaffold(
      gradientBackground: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: AppSizes.mediumSpacing,
            ),
            Image.asset(
              ImageAssets.logo,
              height: context.isLargerThanMobile
                  ? AppSizes.appLogoWeb
                  : AppSizes.appLogo,
            ),
            const SizedBox(
              height: AppSizes.normalSpacing,
            ),
            DisplayText(
              S.current.photo_pulse,
              color: AppColors.primaryDefault,
              fontSize:
                  context.isLargerThanMobile ? FontSizes.s30 : FontSizes.s24,
              fontFamily: 'Cocogoose Pro',
            ),
            const SizedBox(
              height: AppSizes.mediumSpacing,
            ),
            FormBuilder(
              key: formKey,
              onChanged: () => _refreshNextEnabled(ref),
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
                  const SizedBox(height: AppSizes.normalSpacing),
                  PhotoPulseTextFormField.passwordTextField(
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    name: LoginFormConfig.passwordKey,
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    labelText: S.current.password,
                  ),
                  const SizedBox(height: AppSizes.largeSpacing),
                  PhotoPulseButton.primary(
                    label: S.current.login,
                    isLoading: false,
                    onTap: () {},
                    isEnabled: ref.watch(isNextEnabled),
                  ),
                  const SizedBox(
                    height: AppSizes.largeSpacing,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const BodyText('Don\'t have an account?'),
                      const SizedBox(
                        width: AppSizes.smallSpacing,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: BodyText(
                          'Register',
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                  const OrDivider(),
                  const SocialLoginSection(),
                  const SizedBox(
                    height: AppSizes.normalSpacing,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const BodyText('Continue without signing in'),
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

void _refreshNextEnabled(WidgetRef ref) =>
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(isNextEnabled.notifier).state =
            formKey.currentState?.saveAndValidate(focusOnInvalid: false) ??
                false;
      },
    );
