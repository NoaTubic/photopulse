// ignore_for_file: always_use_package_imports
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardPage extends ConsumerWidget {
  static const routeName = '/dashboard';

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: const [
        // Text(
        //   'Dashboard',
        //   style: context.appTextStyles.bold,
        //   textAlign: TextAlign.center,
        // ),
        // const SizedBox(height: AppSizes.normalSpacing),
        // TextButton(
        //   onPressed: ref.read(authNotifierProvider.notifier).logout,
        //   child: Text(
        //     'Logout',
        //     style: context.appTextStyles.regular,
        //   ),
        // ),
        // const SizedBox(height: AppSizes.normalSpacing),
        // const SizedBox(height: AppSizes.normalSpacing),
        // TextButton(
        //   onPressed: () => ref.pushNamed(
        //     ref.getRouteNameFromCurrentLocation(
        //       UserDetailsPage.getRouteNameWithParams(1),
        //     ),
        //   ),
        //   child: Text(
        //     'Dashboard -> User details 1',
        //     style: context.appTextStyles.bold,
        //   ),
        // ),
        // const SizedBox(height: AppSizes.normalSpacing),
        // TextButton(
        //   onPressed: () => ref.pushNamed(
        //     '${UsersPage.routeName}${UserDetailsPage.getRouteNameWithParams(1)}',
        //   ),
        //   child: Text(
        //     'Users -> User details 1',
        //     style: context.appTextStyles.bold,
        //   ),
        // ),
      ],
    );
  }
}
