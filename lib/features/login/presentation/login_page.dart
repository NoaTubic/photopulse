// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/image_assets.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/common/presentation/photo_pulse_text__form_field.dart';
import 'package:photopulse/common/presentation/text/display_text.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:photopulse/theme/app_colors.dart';
import 'package:photopulse/theme/theme.dart';

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
            PhotoPulseTextFormField.normalTextField(
              name: 'name',
              labelText: S.current.email,
            ),
            const SizedBox(height: AppSizes.largeSpacing),
            PhotoPulseTextFormField.passwordTextField(
              name: 'name',
              labelText: S.current.password,
            ),
          ],
        ),
      ),
    );
  }
}
