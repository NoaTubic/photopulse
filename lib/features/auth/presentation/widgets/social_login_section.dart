// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:loggy/loggy.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/image_assets.dart';
// import 'package:photopulse/features/auth/data/constants/github_auth_constants.dart';
// import 'package:photopulse/features/auth/data/repository/auth_repository.dart';
// import 'package:photopulse/features/auth/data/repository/users_repository.dart';
import 'package:photopulse/features/auth/domain/notifiers/login_notifier.dart';
import 'package:photopulse/features/auth/presentation/pages/github_login_page.dart';

class SocialLoginSection extends ConsumerWidget {
  const SocialLoginSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final GitHubSignIn gitHubSignIn = GitHubSignIn(
    //   clientId: GithubAuthConstants.clientId,
    //   clientSecret: GithubAuthConstants.clientSecret,
    //   redirectUrl: GithubAuthConstants.redirectUrl,
    //   title: 'GitHub Connection',
    //   centerTitle: false,
    // );

    // Future<void> gitHubSignIn0(BuildContext context) async {
    //   final result = await gitHubSignIn.signIn(context);
    //   switch (result.status) {
    //     case GitHubSignInResultStatus.ok:
    //       logDebug(result.token);
    //       await FirebaseAuth.instance.signInWithCredential(
    //         GithubAuthProvider.credential(
    //           result.token!,
    //         ),
    //       );

    //     case GitHubSignInResultStatus.cancelled:
    //       logDebug('cancelled');
    //     case GitHubSignInResultStatus.failed:
    //       logDebug(result.errorMessage);
    //       break;
    //   }
    // }

    final loginNotifier = ref.read(loginNotifierProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PhotoPulseButton.socialLogin(
          icon: ImageAssets.googleLogo,
          onTap: () => loginNotifier.loginWithGoogle(),
        ),
        const SizedBox(
          width: AppSizes.largeSpacing,
        ),
        PhotoPulseButton.socialLogin(
          icon: ImageAssets.githubLogo,
          onTap: () =>
              // gitHubSignIn0(context),
              _loginWithGithub(context),
        ),
      ],
    );
  }
}

void _loginWithGithub(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (builder) {
        return const GitHubSignInPage();
      },
    ),
  );
}
