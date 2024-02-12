// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/generated/l10n.dart';

class ResetPasswordPage extends ConsumerWidget {
  static const routeName = '/reset-password';

  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.reset_password)),
      body: ListView(
        children: [
          TextButton(
            onPressed: ref.pop,
            child: Text(S.current.go_back),
          ),
        ],
      ),
    );
  }
}
