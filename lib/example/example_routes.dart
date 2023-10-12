import 'package:flutter/widgets.dart';
// ignore_for_file: always_use_package_imports
import 'package:go_router/go_router.dart';

import '../common/domain/utils/string_extension.dart';
import 'presentation/pages/example_page.dart';
import 'presentation/pages/example_simple_page.dart';
import 'presentation/pages/form_example_page.dart';
import 'presentation/pages/pagination_example_page.dart';
import 'presentation/pages/pagination_stream_example_page.dart';

RouteBase getExampleRoutes({
  required GlobalKey<NavigatorState> rootNavigatorKey,
}) =>
    GoRoute(
      path: ExamplePage.routeName.removeLeadingSlash,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const ExamplePage(),
      routes: [
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: ExampleSimplePage.routeName.removeLeadingSlash,
          builder: (context, state) => const ExampleSimplePage(),
        ),
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: FormExamplePage.routeName.removeLeadingSlash,
          builder: (context, state) => FormExamplePage(),
        ),
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: PaginationExamplePage.routeName.removeLeadingSlash,
          builder: (context, state) => const PaginationExamplePage(),
        ),
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: PaginationStreamExamplePage.routeName.removeLeadingSlash,
          builder: (context, state) => const PaginationStreamExamplePage(),
        ),
      ],
    );
