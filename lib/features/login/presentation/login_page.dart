// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/domain/router/navigation_extensions.dart';
import '../../../common/presentation/app_sizes.dart';
import '../../auth/domain/notifiers/auth_notifier.dart';
import '../../register/presentation/register_page.dart';
import '../../reset_password/presentation/reset_password_page.dart';

class LoginPage extends ConsumerWidget {
  static const routeName = '/login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: ListView(
        children: [
          TextButton(
            onPressed: () => ref
                .read(authNotifierProvider.notifier)
                .login(email: 'email', password: 'password'),
            child: const Text('Login'),
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          TextButton(
            onPressed: () =>
                ref.pushNamed('$routeName${ResetPasswordPage.routeName}'),
            child: const Text('Reset Password'),
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          TextButton(
            onPressed: () =>
                ref.pushNamed('$routeName${RegisterPage.routeName}'),
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
