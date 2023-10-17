// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/common_validators.dart';
import 'package:photopulse/common/presentation/image_assets.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/common/presentation/photo_pulse_text__form_field.dart';
import 'package:photopulse/common/presentation/text/display_text.dart';
import 'package:photopulse/features/auth/forms/login_form_config.dart';
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: AppSizes.largeSpacing,
            ),
            Image.asset(ImageAssets.logo, height: AppSizes.appLogo),
            const SizedBox(
              height: AppSizes.mediumSpacing,
            ),
            DisplayText(
              S.current.photo_pulse,
              color: AppColors.primaryDefault,
              fontSize: FontSizes.s30,
            ),
            const SizedBox(
              height: AppSizes.xLargeSpacing,
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
                  const SizedBox(height: AppSizes.largeSpacing),
                  PhotoPulseTextFormField.passwordTextField(
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    name: LoginFormConfig.passwordKey,
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    labelText: S.current.password,
                  ),
                  const SizedBox(height: AppSizes.xLargeSpacing),
                  PhotoPulseButton.primary(
                    label: S.current.login,
                    isLoading: false,
                    onTap: () {},
                    isEnabled: ref.watch(isNextEnabled),
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(isNextEnabled.notifier).state =
          formKey.currentState?.saveAndValidate() ?? false;
    });
