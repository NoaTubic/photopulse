import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/presentation/image_assets.dart';
import 'package:photopulse/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:photopulse/features/auth/presentation/pages/login_page.dart';
import 'package:photopulse/features/feed/presentation/pages/home_page.dart';

class SplashPage extends ConsumerWidget {
  static const routeName = Pages.splash;

  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    toSignIn(ref);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(ImageAssets.logo),
          ),
        ],
      ),
    );
  }
}

Future<void> toSignIn(WidgetRef ref) async {
  await Future.delayed(const Duration(seconds: 2));
  if (ref.context.mounted) {
    if (!kIsWeb) {
      ref.read(authNotifierProvider.notifier).listenAuthChanges();
    }
    ref.pushNamed(HomePage.routeName);
  }
}
