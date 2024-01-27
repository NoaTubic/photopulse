// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/presentation/gradient_background.dart';
import 'package:photopulse/features/auth/domain/notifiers/user_notifier.dart';
import 'package:photopulse/features/subscription_management/presentation/pages/subscription_management_page.dart';

class HomePage extends ConsumerWidget {
  static const routeName = Pages.home;

  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    ref.listen(userProvider, (_, next) {
      if (next != null && next.isFirstLogin) {
        ref.pushReplacementNamed(
          SubscriptionManagementPage.routeName,
        );
      }
    });
    return const Stack(
      children: [
        GradientBackground(),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Home Page'),
          ],
        ),
      ],
    );
  }
}
