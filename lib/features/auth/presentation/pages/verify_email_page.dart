import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/presentation/animated_widgets/animated_column.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_text_button.dart';
import 'package:photopulse/common/presentation/photo_pulse_app_bar.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/common/presentation/photo_pulse_toast.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/common/utils/build_context_extensions.dart';
import 'package:photopulse/features/auth/domain/notifiers/registration_notifier.dart';
import 'package:photopulse/features/auth/presentation/pages/login_page.dart';
import 'package:photopulse/features/auth/presentation/widgets/text_button_row.dart';
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
        title: S.current.verify_email,
        onTap: () => ref.pushReplacementNamed(LoginPage.routeName),
      ),
      body: Center(
        child: AnimatedColumn(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: AppSizes.xLargeSpacing,
            ),
            BodyText(S.current.verify_email_subtitle),
            const SizedBox(height: AppSizes.mediumSpacing),
            DisplayText(
              S.current.photo_pulse,
              color: AppColors.black,
              fontSize:
                  context.isLargerThanMobile ? FontSizes.s30 : FontSizes.s24,
              fontFamily: Fonts.fontLogo,
            ),
            const SizedBox(height: AppSizes.normalSpacing),
            const Icon(
              Icons.domain_verification_rounded,
              size: AppSizes.verifyEmailIconSize,
            ),
            const SizedBox(height: AppSizes.mediumSpacing),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: BodyText(
                S.current.verify_email_helper,
                isCentered: true,
              ),
            ),
            const SizedBox(
              height: AppSizes.mediumSpacing,
            ),
            TextButtonRow(
              text: S.current.didnt_receive_verification_email,
              buttonText: S.current.resend_verification_email,
              onTap: () {
                ref
                    .read(registrationNotifierProvider.notifier)
                    .verifyEmail()
                    .then(
                      ((value) => PhotoPulseToast(
                              message:
                                  S.current.verification_email_resend_success)
                          .show(context)),
                    );
              },
            ),
            const SizedBox(
              height: AppSizes.mediumSpacing,
            ),
            PhotoPulseTextButton(
              onTap: () => ref.pushReplacementNamed(LoginPage.routeName),
              label: S.current.login,
            ),
          ],
        ),
      ),
    );
  }
}
