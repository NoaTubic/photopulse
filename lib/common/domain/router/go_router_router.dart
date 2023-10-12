// ignore_for_file: always_use_package_imports
// ignore_for_file: avoid-dynamic

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'base_router.dart';

class GoRouterRouter extends BaseRouter {
  GoRouterRouter({
    required super.routerDelegate,
    required super.routeInformationParser,
    super.routeInformationProvider,
    super.router,
  });

  @override
  BuildContext? get navigatorContext =>
      (router as GoRouter).routerDelegate.navigatorKey.currentContext;

  @override
  void pop() {
    (router as GoRouter).pop();
  }

  @override
  void pushNamed(String routeName, {dynamic data}) {
    (router as GoRouter).go(routeName, extra: data);
  }

  @override
  void pushReplacementNamed(String routeName, {dynamic data}) {
    (router as GoRouter).replace(routeName, extra: data);
  }

  @override
  dynamic get getData => throw UnsupportedError(
        'getData should not be called directly, instead it can be accessed through GoRouterState in GoRoute constructor',
      );

  @override
  Uri get currentLocationUri =>
      (routerDelegate as GoRouterDelegate).currentConfiguration.uri;

  @override
  bool routeExists(String route) {
    try {
      return (routeInformationParser as GoRouteInformationParser)
          .configuration
          .findMatch(route)
          .matches
          .isNotEmpty;
    } catch (err) {
      return false;
    }
  }
}
