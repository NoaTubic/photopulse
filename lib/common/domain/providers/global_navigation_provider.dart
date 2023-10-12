// ignore_for_file: always_use_package_imports
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../router/route_action.dart';

final globalNavigationProvider = StateProvider<RouteAction?>((_) => null);
