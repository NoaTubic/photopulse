import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/presentation/photo_pulse_app_bar.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/features/auth/presentation/pages/login_page.dart';

class VerifyEmailPage extends ConsumerWidget {
  static const String routeName = Pages.verifyEmail;

  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PhotoPulseScaffold(
      appBar: PhotoPulseAppBar.withBackNav(
        onTap: () => ref.pushReplacementNamed(LoginPage.routeName),
      ),
      body: const Center(
        child: Column(),
      ),
    );
  }
}
