// ignore_for_file: always_use_package_imports
// ignore_for_file: avoid-dynamic
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../features/home/presentation/home_page.dart';
import '../providers/base_router_provider.dart';
import '../providers/global_navigation_provider.dart';
import 'route_action.dart';

extension NavigationExtensions on WidgetRef {
  void pop() =>
      read(globalNavigationProvider.notifier).update((_) => PopAction());

  void pushNamed(String routeName, {dynamic data}) =>
      read(globalNavigationProvider.notifier)
          .update((_) => PushNamedAction(routeName, data));

  void pushReplacementNamed(String routeName, {dynamic data}) =>
      read(globalNavigationProvider.notifier)
          .update((_) => PushReplacementNamedAction(routeName, data));

  ({String currentRouteName, Map<String, String?> queryParameters})
      get _currentNavigationLocation {
    final location = read(baseRouterProvider).currentLocationUri;
    final currentRoute = location.path;
    return (
      currentRouteName: currentRoute == HomePage.routeName ? '' : currentRoute,
      queryParameters: location.queryParameters
    );
  }

  String getRouteNameFromCurrentLocation(
    String routeName, {
    bool keepExistingQueryString = true,
  }) {
    final (:currentRouteName, :queryParameters) = _currentNavigationLocation;
    final routeNameUri = Uri.tryParse(routeName);
    final newRoute = '$currentRouteName${routeNameUri?.path ?? ''}';
    final newQueryParameters =
        keepExistingQueryString ? Map.of(queryParameters) : <String, dynamic>{};
    if (routeNameUri?.queryParameters.isNotEmpty == true) {
      for (final item in routeNameUri!.queryParameters.entries) {
        newQueryParameters.containsKey(item.key)
            ? newQueryParameters[item.key] = item.value
            : newQueryParameters.putIfAbsent(item.key, () => item.value);
      }
    }
    final newRouteUri = Uri(
      path: newRoute,
      queryParameters:
          newQueryParameters.isNotEmpty ? newQueryParameters : null,
    );
    return newRouteUri.toString();
  }
}
