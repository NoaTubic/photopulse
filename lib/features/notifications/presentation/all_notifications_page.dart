// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/domain/router/navigation_extensions.dart';
import '../../../common/presentation/app_sizes.dart';
import '../../../common/presentation/build_context_extensions.dart';
import 'notification_details_page.dart';

class AllNotificationsPage extends ConsumerWidget {
  static const routeName = '/all';

  const AllNotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Notifications')),
      body: ListView(
        children: [
          TextButton(
            onPressed: () => ref.pushNamed(ref.getRouteNameFromCurrentLocation(
              NotificationDetailsPage.getRouteNameWithParams(1),
            )),
            child: Text(
              'Notification details 1',
              style: context.appTextStyles.regular,
            ),
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          TextButton(
            onPressed: () => ref.pushNamed(ref.getRouteNameFromCurrentLocation(
              NotificationDetailsPage.getRouteNameWithParams(2),
            )),
            child: Text(
              'Notification details 2',
              style: context.appTextStyles.regular,
            ),
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          TextButton(
            onPressed: () => ref.pushNamed(ref.getRouteNameFromCurrentLocation(
              NotificationDetailsPage.getRouteNameWithParams(3),
            )),
            child: Text(
              'Notification details 3',
              style: context.appTextStyles.regular,
            ),
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          TextButton(
            onPressed: () => ref.pushNamed(ref.getRouteNameFromCurrentLocation(
              NotificationDetailsPage.getRouteNameWithParams(4),
            )),
            child: Text(
              'Notification details 4',
              style: context.appTextStyles.regular,
            ),
          ),
        ],
      ),
    );
  }
}
