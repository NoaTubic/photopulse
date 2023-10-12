// ignore_for_file: always_use_package_imports
// ignore_for_file: avoid-dynamic

import 'base_router.dart';

abstract class RouteAction<T> {
  final String routeName;
  final dynamic data;

  RouteAction([this.routeName = '', this.data]);

  void execute(BaseRouter baseRouter);

  @override
  String toString() => routeName;
}

class PushNamedAction<T> extends RouteAction {
  PushNamedAction(super.routeName, super.data);

  @override
  void execute(BaseRouter baseRouter) =>
      baseRouter.pushNamed(routeName, data: data);
}

class PopAction extends RouteAction {
  @override
  void execute(BaseRouter baseRouter) => baseRouter.pop();
}

class PushReplacementNamedAction extends RouteAction {
  PushReplacementNamedAction(super.routeName, super.data);

  @override
  void execute(BaseRouter baseRouter) =>
      baseRouter.pushReplacementNamed(routeName, data: data);
}
