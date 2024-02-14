import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_text_button.dart';
import 'package:photopulse/common/presentation/photo_pulse_app_bar.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/common/presentation/photo_pulse_toast.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/common/utils/build_context_extensions.dart';
import 'package:photopulse/features/auth/domain/notifiers/registration_notifier.dart';
import 'package:photopulse/features/auth/presentation/pages/login_page.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:photopulse/theme/app_colors.dart';
import 'package:photopulse/theme/theme.dart';

class VerifyEmailPage extends ConsumerWidget {
  static const String routeName = Pages.verifyEmail;

  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PhotoPulseScaffold(
      appBar: PhotoPulseAppBar.withBackNav(
        title: 'Verify Email',
        onTap: () => ref.pushReplacementNamed(LoginPage.routeName),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: AppSizes.largeSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const BodyText('Almost ready to start using '),
                const SizedBox(width: AppSizes.tinySpacing),
                DisplayText(
                  S.current.photo_pulse,
                  color: AppColors.black,
                  fontSize: context.isLargerThanMobile
                      ? FontSizes.s30
                      : FontSizes.s24,
                  fontFamily: Fonts.fontLogo,
                ),
                const Text('.'),
              ],
            ),
            const SizedBox(height: AppSizes.largeSpacing),
            const Icon(
              Icons.domain_verification_rounded,
              size: 100,
            ),
            const SizedBox(height: AppSizes.largeSpacing),
            const Text(
              'Please check your inbox and verify your email address.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: AppSizes.xLargeSpacing,
            ),
            TextButtonRow(
              text: 'Didn\'t receive an email? ',
              buttonText: 'Resend email',
              onTap: () {
                ref
                    .read(registrationNotifierProvider.notifier)
                    .verifyEmail()
                    .then(
                      ((value) => const PhotoPulseToast(
                              message:
                                  's.email_verification_resent_email_info,')
                          .show(context)),
                    );
              },
            ),
            const SizedBox(
              height: AppSizes.largeSpacing,
            ),
            TextButton(
              onPressed: () => ref.pushReplacementNamed(LoginPage.routeName),
              child: Text(S.current.login),
            ),
          ],
        ),
      ),
    );
  }
}

class TextButtonRow extends StatelessWidget {
  final String text;
  final String buttonText;
  final void Function() onTap;

  const TextButtonRow({
    super.key,
    required this.text,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        PhotoPulseTextButton(
          onTap: onTap,
          label: buttonText,
          textColor: AppColors.black,
        ),
      ],
    );
  }
}
