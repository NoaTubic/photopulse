// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/domain/providers/base_router_provider.dart';
import '../../../common/domain/router/navigation_extensions.dart';
import '../../auth/domain/notifiers/auth_notifier.dart';
import '../../auth/domain/notifiers/auth_state.dart';
import '../domain/entity/bottom_navigation_item.dart';

class HomePage extends ConsumerWidget {
  static const routeName = '/';

  final StatefulNavigationShell? navigationShell;
  final Widget? child;

  const HomePage({super.key, this.navigationShell, this.child})
      : assert(navigationShell != null || child != null);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    return switch (authState) {
      AuthStateAuthenticated() => Scaffold(
          body: navigationShell ?? child,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: BottomNavigationItem.values
                .map((e) => BottomNavigationBarItem(
                      icon: Icon(e.icon),
                      label: e.title,
                    ))
                .toList(),
            currentIndex: navigationShell != null
                ? navigationShell!.currentIndex
                : BottomNavigationItem.getIndexForLocation(
                    ref.read(baseRouterProvider).currentLocationUri.path,
                  ),
            onTap: (value) => _onItemTapped(ref: ref, index: value),
          ),
        ),
      _ => const Scaffold(body: SizedBox()),
    };
  }

  void _onItemTapped({required WidgetRef ref, required int index}) {
    if (navigationShell != null) {
      navigationShell!.goBranch(
        index,
        initialLocation: index == navigationShell!.currentIndex,
      );
    } else {
      for (final item in BottomNavigationItem.values) {
        if (index == item.index) {
          ref.pushNamed(item.routeName);
          break;
        }
      }
    }
  }
}
