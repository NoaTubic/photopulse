import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/image_assets.dart';
import 'package:photopulse/features/auth/domain/notifiers/login_notifier.dart';

class SocialLoginSection extends ConsumerWidget {
  const SocialLoginSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.read(loginNotifierProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PhotoPulseButton.socialLogin(
          icon: ImageAssets.googleLogo,
          onTap: () => loginNotifier.loginWithGoogle(),
        ),
      ],
    );
  }
}
