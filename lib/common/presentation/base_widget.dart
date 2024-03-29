// ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../domain/providers/base_router_provider.dart';
import '../domain/providers/global_navigation_provider.dart';
import '../domain/router/route_action.dart';

class BaseWidget extends ConsumerWidget {
  final Widget child;

  const BaseWidget(
    this.child, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.globalFailureListener();
    ref.globalInfoListener();
    ref.globalNavigationListener();
    final showLoading = ref.watch(globalLoadingProvider);
    return Stack(
      children: [
        ResponsiveBreakpoints.builder(
          child: (child),
          breakpoints: [
            const Breakpoint(
              start: 0,
              end: 450,
              name: MOBILE,
            ),
            const Breakpoint(
              start: 768,
              end: 1024,
              name: TABLET,
            ),
            const Breakpoint(
              start: 1025,
              end: 1920,
              name: DESKTOP,
            ),
            const Breakpoint(
              start: 1921,
              end: double.infinity,
              name: '4K',
            ),
          ],
        ),
        if (showLoading) const BaseLoadingIndicator(),
      ],
    );
  }
}

extension _WidgetRefExtensions on WidgetRef {
  void globalFailureListener() {
    listen<Failure?>(globalFailureProvider, (_, failure) {
      if (failure == null) return;
      //Show global error
      logError('''
        showing ${failure.isCritical ? '' : 'non-'}critical failure with 
        title ${failure.title}, 
        error: ${failure.error},
        stackTrace: ${failure.stackTrace}
      ''');
    });
  }

  void globalInfoListener() {
    listen<GlobalInfo?>(globalInfoProvider, (_, globalInfo) {
      if (globalInfo == null) return;
      //Show global error
      logInfo(''' 
        globalInfoStatus: ${globalInfo.globalInfoStatus}
        title: ${globalInfo.title}, 
        message: ${globalInfo.message},
      ''');
    });
  }

  void globalNavigationListener() {
    listen<RouteAction?>(
      globalNavigationProvider,
      (_, state) => state?.execute(read(baseRouterProvider)),
    );
  }
}
