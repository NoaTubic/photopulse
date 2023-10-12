// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/domain/router/navigation_extensions.dart';

class RegisterPage extends ConsumerWidget {
  static const routeName = '/register';

  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: ListView(
        children: [
          TextButton(
            onPressed: ref.pop,
            child: const Text('Go back'),
          ),
        ],
      ),
    );
  }
}
