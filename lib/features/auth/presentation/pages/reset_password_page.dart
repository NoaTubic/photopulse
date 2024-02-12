// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/domain/utils/base_state_extensions.dart';
import 'package:photopulse/common/presentation/animated_widgets/animated_column.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_text_button.dart';
import 'package:photopulse/common/presentation/common_validators.dart';
import 'package:photopulse/common/presentation/photo_pulse_app_bar.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/common/presentation/photo_pulse_text_form_field.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/features/auth/domain/notifiers/account_recovery_notifier.dart';
import 'package:photopulse/generated/l10n.dart';

final formKey = GlobalKey<FormBuilderState>();

class ResetPasswordPage extends HookConsumerWidget {
  static const routeName = Pages.resetPassword;

  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resetPasswordState = ref.watch(accountRecoveryNotifierProvider);
    final TextEditingController controller = useTextEditingController();
    return PhotoPulseScaffold(
      appBar: PhotoPulseAppBar.withBackNav(
          onTap: ref.pop, title: S.current.reset_password),
      body: AnimatedColumn(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const BodyText('Forgot your password?'),
          const BodyText(
              'Please enter your email address to reset your password.'),
          const SizedBox(height: AppSizes.mediumSpacing),
          FormBuilder(
            key: formKey,
            child: PhotoPulseTextFormField.normalTextField(
              controller: controller,
              name: '',
              labelText: S.current.email,
              validators: [
                CommonValidators.email(),
                CommonValidators.requiredEmail(),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.mediumSpacing),
          PhotoPulseButton.primary(
            label: S.current.reset_password,
            onTap: () {
              if (formKey.currentState?.saveAndValidate() ?? false) {
                ref
                    .read(accountRecoveryNotifierProvider.notifier)
                    .resetPassword(
                      controller.text,
                    );
                ref.pop();
              }
            },
            isLoading: resetPasswordState.isLoading,
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          PhotoPulseTextButton(
            onTap: ref.pop,
            label: S.current.go_back,
          ),
        ],
      ),
    );
  }
}
