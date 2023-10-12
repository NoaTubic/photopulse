// ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:shake/shake.dart';

import '../../main/app_environment.dart';
import '../domain/providers/base_router_provider.dart';
import '../domain/providers/global_navigation_provider.dart';
import '../domain/router/route_action.dart';
import '../utils/q_logger.dart';

class BaseWidget extends ConsumerStatefulWidget {
  final Widget child;

  const BaseWidget(
    this.child, {
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _BaseWidgetState();
}

class _BaseWidgetState extends ConsumerState<BaseWidget> {
  ShakeDetector? shakeDetector;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!EnvInfo.isProduction) {
        final navigatorContext = ref.read(baseRouterProvider).navigatorContext;
        if (navigatorContext != null) {
          shakeDetector = ShakeDetector.autoStart(
            onPhoneShake: () => QLogger.showLogger(navigatorContext),
          );
        }
      }
      // ref.read(appTrackingTransparencyChannelProvider).requestTracking();
    });

    super.initState();
  }

  @override
  void dispose() {
    shakeDetector?.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if you need context to showDialog or bottomSheet, use BaseRouter's navigatorContext because main context
    // won't work as BaseWidget is the first widget in builder method of MaterialApp.router so Navigator is not ready yet.
    // Be careful not to use it directly in build method (it is not ready yet), but in button callback or within
    // WidgetsBinding.instance.addPostFrameCallback.
    // final navigatorContext = ref.read(baseRouterProvider).navigatorContext;
    ref.globalFailureListener();
    ref.globalInfoListener();
    ref.globalNavigationListener();
    final showLoading = ref.watch(globalLoadingProvider);
    return Stack(
      children: [
        widget.child,
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
