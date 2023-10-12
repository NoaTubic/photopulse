// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/presentation/build_context_extensions.dart';

class UserDetailsPage extends ConsumerWidget {
  static const routeName = '/details/$pathPattern';
  static const pathPattern = ':userId';
  static const queryParameterKey = 'optional';

  static String getRouteNameWithParams(
    int userId, {
    String? optional,
  }) =>
      '${routeName.replaceAll(pathPattern, '$userId')}${optional != null ? '?$queryParameterKey=$optional' : ''}';

  final int userId;

  const UserDetailsPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('User details')),
      body: ListView(
        children: [
          Text(
            'User id: $userId',
            style: context.appTextStyles.boldLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
