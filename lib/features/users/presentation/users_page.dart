// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/domain/router/navigation_extensions.dart';
import '../../../common/presentation/app_sizes.dart';
import '../../../common/presentation/build_context_extensions.dart';
import '../../../features/users/presentation/user_details_page.dart';

class UsersPage extends ConsumerWidget {
  static const routeName = '/users';

  const UsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Text(
          'Users',
          style: context.appTextStyles.boldLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSizes.normalSpacing),
        TextButton(
          onPressed: () => ref.pushNamed(
            ref.getRouteNameFromCurrentLocation(
              UserDetailsPage.getRouteNameWithParams(1, optional: 'abc'),
            ),
          ),
          child: Text(
            'User 1',
            style: context.appTextStyles.bold,
          ),
        ),
        const SizedBox(height: AppSizes.normalSpacing),
        TextButton(
          onPressed: () => ref.pushNamed(
            ref.getRouteNameFromCurrentLocation(
              UserDetailsPage.getRouteNameWithParams(2),
              keepExistingQueryString: false,
            ),
          ),
          child: Text(
            'User 2',
            style: context.appTextStyles.bold,
          ),
        ),
        const SizedBox(height: AppSizes.normalSpacing),
        TextButton(
          onPressed: () => ref.pushNamed(
            '${UsersPage.routeName}${UserDetailsPage.routeName.replaceAll(UserDetailsPage.pathPattern, 'R')}',
          ),
          child: Text(
            'User R',
            style: context.appTextStyles.bold,
          ),
        ),
      ],
    );
  }
}
