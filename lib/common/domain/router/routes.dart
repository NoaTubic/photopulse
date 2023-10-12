// ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/domain/utils/string_extension.dart';
import '../../../example/example_routes.dart';
import '../../../features/dashboard/presentation/dashboard_page.dart';
import '../../../features/directories/presentation/directories_page.dart';
import '../../../features/home/presentation/home_page.dart';
import '../../../features/login/presentation/login_page.dart';
import '../../../features/notifications/presentation/all_notifications_page.dart';
import '../../../features/notifications/presentation/notification_details_page.dart';
import '../../../features/notifications/presentation/notifications_page.dart';
import '../../../features/register/presentation/register_page.dart';
import '../../../features/reset_password/presentation/reset_password_page.dart';
import '../../../features/users/presentation/user_details_page.dart';
import '../../../features/users/presentation/users_page.dart';

List<RouteBase> getRoutes({
  required GlobalKey<NavigatorState> rootNavigatorKey,
  bool stateful = true,
}) =>
    [
      GoRoute(
        path: HomePage.routeName,
        redirect: (context, state) => DashboardPage.routeName,
      ),
      if (stateful)
        _statefulShellRoute(rootNavigatorKey: rootNavigatorKey)
      else
        _shellRoute(rootNavigatorKey: rootNavigatorKey),
      GoRoute(
        path: LoginPage.routeName,
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: ResetPasswordPage.routeName.lastPart,
            builder: (context, state) => const ResetPasswordPage(),
          ),
          GoRoute(
            path: RegisterPage.routeName.lastPart,
            builder: (context, state) => const RegisterPage(),
          ),
        ],
      ),
    ];

RouteBase _statefulShellRoute({
  required GlobalKey<NavigatorState> rootNavigatorKey,
}) =>
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          HomePage(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: DashboardPage.routeName,
            builder: (context, state) => const DashboardPage(),
            routes: [
              GoRoute(
                path: UserDetailsPage.routeName.removeLeadingSlash,
                builder: (context, state) => UserDetailsPage(
                  userId: int.parse(state.pathParameters[
                      UserDetailsPage.pathPattern.removeLeadingColon]!),
                ),
                redirect: (context, state) => state.pathParameters.containsKey(
                          UserDetailsPage.pathPattern.removeLeadingColon,
                        ) &&
                        int.tryParse(state.pathParameters[UserDetailsPage
                                .pathPattern.removeLeadingColon]!) !=
                            null
                    ? null
                    : UsersPage.routeName,
              ),
              getExampleRoutes(rootNavigatorKey: rootNavigatorKey),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: UsersPage.routeName,
            builder: (context, state) => const UsersPage(),
            routes: [
              GoRoute(
                path: UserDetailsPage.routeName.removeLeadingSlash,
                builder: (context, state) => UserDetailsPage(
                  userId: int.parse(state.pathParameters[
                      UserDetailsPage.pathPattern.removeLeadingColon]!),
                ),
                redirect: (context, state) => state.pathParameters.containsKey(
                          UserDetailsPage.pathPattern.removeLeadingColon,
                        ) &&
                        int.tryParse(state.pathParameters[UserDetailsPage
                                .pathPattern.removeLeadingColon]!) !=
                            null
                    ? null
                    : UsersPage.routeName,
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: NotificationsPage.routeName,
            builder: (context, state) => const NotificationsPage(),
            routes: [
              GoRoute(
                path: AllNotificationsPage.routeName.removeLeadingSlash,
                builder: (context, state) => const AllNotificationsPage(),
                routes: [
                  GoRoute(
                    path: NotificationDetailsPage.routeName.removeLeadingSlash,
                    builder: (context, state) => NotificationDetailsPage(
                      notificationId: int.parse(state.pathParameters[
                          NotificationDetailsPage
                              .pathPattern.removeLeadingColon]!),
                    ),
                    redirect: (context, state) => state.pathParameters
                                .containsKey(
                              NotificationDetailsPage
                                  .pathPattern.removeLeadingColon,
                            ) &&
                            int.tryParse(state.pathParameters[
                                    NotificationDetailsPage
                                        .pathPattern.removeLeadingColon]!) !=
                                null
                        ? null
                        : '${NotificationsPage.routeName}${AllNotificationsPage.routeName}',
                  ),
                ],
              ),
              GoRoute(
                path: NotificationDetailsPage.routeName.removeLeadingSlash,
                builder: (context, state) => NotificationDetailsPage(
                  notificationId: int.parse(state.pathParameters[
                      NotificationDetailsPage.pathPattern.removeLeadingColon]!),
                ),
                redirect: (context, state) => state.pathParameters.containsKey(
                          NotificationDetailsPage
                              .pathPattern.removeLeadingColon,
                        ) &&
                        int.tryParse(state.pathParameters[
                                NotificationDetailsPage
                                    .pathPattern.removeLeadingColon]!) !=
                            null
                    ? null
                    : NotificationsPage.routeName,
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: DirectoriesPage.routeName,
            builder: (context, state) => const DirectoriesPage(),
            routes: [
              _buildRoutesRecursively(
                depth: 10,
                pathCallback: (depth) => DirectoriesPage.pathPattern(depth),
                builderCallback: (context, state, depth) => DirectoriesPage(
                  directoryName: state.pathParameters[
                      DirectoriesPage.pathPattern(depth).removeLeadingColon],
                  canGoDeeper: depth > 1,
                ),
              ),
            ],
          ),
        ]),
      ],
    );

RouteBase _shellRoute({required GlobalKey<NavigatorState> rootNavigatorKey}) =>
    ShellRoute(
      builder: (context, state, child) => HomePage(child: child),
      routes: [
        GoRoute(
          path: DashboardPage.routeName,
          builder: (context, state) => const DashboardPage(),
          routes: [
            GoRoute(
              path: UserDetailsPage.routeName.removeLeadingSlash,
              builder: (context, state) => UserDetailsPage(
                userId: int.parse(state.pathParameters[
                    UserDetailsPage.pathPattern.removeLeadingColon]!),
              ),
              redirect: (context, state) => state.pathParameters.containsKey(
                        UserDetailsPage.pathPattern.removeLeadingColon,
                      ) &&
                      int.tryParse(state.pathParameters[UserDetailsPage
                              .pathPattern.removeLeadingColon]!) !=
                          null
                  ? null
                  : UsersPage.routeName,
            ),
          ],
        ),
        GoRoute(
          path: UsersPage.routeName,
          builder: (context, state) => const UsersPage(),
          routes: [
            GoRoute(
              path: UserDetailsPage.routeName.removeLeadingSlash,
              builder: (context, state) => UserDetailsPage(
                userId: int.parse(state.pathParameters['userId']!),
              ),
              redirect: (context, state) =>
                  state.pathParameters.containsKey('userId') &&
                          int.tryParse(state.pathParameters['userId']!) != null
                      ? null
                      : UsersPage.routeName,
            ),
          ],
        ),
        GoRoute(
          path: NotificationsPage.routeName,
          builder: (context, state) => const NotificationsPage(),
          routes: [
            GoRoute(
              path: AllNotificationsPage.routeName.removeLeadingSlash,
              builder: (context, state) => const AllNotificationsPage(),
              routes: [
                GoRoute(
                  path: NotificationDetailsPage.routeName.removeLeadingSlash,
                  builder: (context, state) => NotificationDetailsPage(
                    notificationId: int.parse(state.pathParameters[
                        NotificationDetailsPage
                            .pathPattern.removeLeadingColon]!),
                  ),
                  redirect: (context, state) => state.pathParameters
                              .containsKey(
                            NotificationDetailsPage
                                .pathPattern.removeLeadingColon,
                          ) &&
                          int.tryParse(state.pathParameters[
                                  NotificationDetailsPage
                                      .pathPattern.removeLeadingColon]!) !=
                              null
                      ? null
                      : '${NotificationsPage.routeName}${AllNotificationsPage.routeName}',
                ),
              ],
            ),
            GoRoute(
              path: NotificationDetailsPage.routeName.removeLeadingSlash,
              builder: (context, state) => NotificationDetailsPage(
                notificationId: int.parse(state.pathParameters[
                    NotificationDetailsPage.pathPattern.removeLeadingColon]!),
              ),
              redirect: (context, state) => state.pathParameters.containsKey(
                        NotificationDetailsPage.pathPattern.removeLeadingColon,
                      ) &&
                      int.tryParse(state.pathParameters[NotificationDetailsPage
                              .pathPattern.removeLeadingColon]!) !=
                          null
                  ? null
                  : NotificationsPage.routeName,
            ),
          ],
        ),
        GoRoute(
          path: DirectoriesPage.routeName,
          builder: (context, state) => const DirectoriesPage(),
          routes: [
            _buildRoutesRecursively(
              depth: 10,
              pathCallback: (depth) => DirectoriesPage.pathPattern(depth),
              builderCallback: (context, state, depth) => DirectoriesPage(
                directoryName: state.pathParameters[
                    DirectoriesPage.pathPattern(depth).removeLeadingColon],
                canGoDeeper: depth > 1,
              ),
            ),
          ],
        ),
      ],
    );

GoRoute _buildRoutesRecursively({
  required int depth,
  required Function(int depth) pathCallback,
  Page Function(BuildContext context, GoRouterState state, int depth)?
      pageBuilderCallback,
  Widget Function(BuildContext context, GoRouterState state, int depth)?
      builderCallback,
  GlobalKey<NavigatorState>? parentNavigatorKey,
}) {
  assert(pageBuilderCallback != null || builderCallback != null);
  return GoRoute(
    parentNavigatorKey: parentNavigatorKey,
    path: pathCallback(depth),
    pageBuilder: pageBuilderCallback != null
        ? (context, state) => pageBuilderCallback(context, state, depth)
        : null,
    builder: builderCallback != null
        ? (context, state) => builderCallback(context, state, depth)
        : null,
    routes: depth == 1
        ? <RouteBase>[]
        : [
            _buildRoutesRecursively(
              depth: depth - 1,
              pathCallback: pathCallback,
              pageBuilderCallback: pageBuilderCallback,
              builderCallback: builderCallback,
              parentNavigatorKey: parentNavigatorKey,
            ),
          ],
  );
}
