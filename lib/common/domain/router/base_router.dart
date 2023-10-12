// ignore_for_file: avoid-dynamic

import 'package:flutter/widgets.dart';

abstract class BaseRouter {
  RouterDelegate<Object> routerDelegate;
  RouteInformationParser<Object> routeInformationParser;
  RouteInformationProvider? routeInformationProvider;
  dynamic router;

  BaseRouter({
    required this.routerDelegate,
    required this.routeInformationParser,
    this.routeInformationProvider,
    this.router,
  });

  BuildContext? get navigatorContext;

  void pushNamed(String routeName, {dynamic data});

  void pop();

  void pushReplacementNamed(String routeName, {dynamic data});

  dynamic get getData;

  Uri get currentLocationUri;

  bool routeExists(String route);
}
