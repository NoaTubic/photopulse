import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/image_assets.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PhotoPulseButton.socialLogin(
          icon: ImageAssets.googleLogo,
          onTap: () {},
        ),
        const SizedBox(
          width: AppSizes.largeSpacing,
        ),
        PhotoPulseButton.socialLogin(
          icon: ImageAssets.githubLogo,
          onTap: () {},
        ),
      ],
    );
  }
}
