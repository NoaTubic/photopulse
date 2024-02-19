// ignore_for_file: always_use_package_imports, avoid-unused-parameters
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:photopulse/features/admin/presentation/pages/admin_page.dart';
import 'package:photopulse/features/auth/presentation/pages/login_page.dart';
import 'package:photopulse/features/auth/presentation/pages/registration_page.dart';
import 'package:photopulse/features/auth/presentation/pages/verify_email_page.dart';
import 'package:photopulse/features/camera/presentation/pages/photo_pulse_camera.dart';
import 'package:photopulse/features/camera/presentation/pages/review_photo_page.dart';
import 'package:photopulse/features/location/domain/entities/post_location.dart';
import 'package:photopulse/features/map/presentation/pages/map_page.dart';
import 'package:photopulse/features/navbar/presentation/pages/nav_bar.dart';
import 'package:photopulse/features/post/domain/entities/post.dart';
import 'package:photopulse/features/post/presentation/pages/post_page.dart';
import 'package:photopulse/features/profile/presentation/pages/profile_page.dart';
import 'package:photopulse/features/search_posts/presentation/pages/search_posts_page.dart';
import 'package:photopulse/features/subscription_management/presentation/pages/subscription_management_page.dart';
import 'package:photopulse/features/upload_content/presentation/pages/upload_content_page.dart';
import '../../../common/domain/utils/string_extension.dart';
import '../../../features/feed/presentation/pages/home_page.dart';
import '../../../features/auth/presentation/pages/reset_password_page.dart';

final GlobalKey<NavigatorState> _homeKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');
final GlobalKey<NavigatorState> _contentKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');
final GlobalKey<NavigatorState> _profileKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');
final GlobalKey<NavigatorState> _searchKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');

List<RouteBase> getRoutes({
  required GlobalKey<NavigatorState> rootNavigatorKey,
}) =>
    [
      // GoRoute(
      //   path: Pages.splash,
      //   redirect: (context, state) => Pages.splash,
      // ),
      GoRoute(
        path: '/',
        redirect: (context, state) => HomePage.routeName,
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            NavBar(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeKey,
            routes: [
              GoRoute(
                path: HomePage.routeName,
                builder: (context, state) => const HomePage(),
                routes: [
                  GoRoute(
                    path: PostPage.routeName.removeLeadingSlash,
                    builder: (context, state) => PostPage(
                      post: state.extra as Post?,
                    ),
                    routes: const [],
                  ),
                  GoRoute(
                    path: MapPage.routeName.removeLeadingSlash,
                    builder: (context, state) => MapPage(
                      location: state.extra as PostLocation,
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: SubscriptionManagementPage.routeName,
                builder: (context, state) => const SubscriptionManagementPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _contentKey,
            routes: [
              GoRoute(
                path: UploadContentPage.routeName,
                builder: (context, state) => const UploadContentPage(),
                routes: [
                  GoRoute(
                    path:
                        SubscriptionManagementPage.routeName.removeLeadingSlash,
                    builder: (context, state) =>
                        const SubscriptionManagementPage(),
                  ),
                  GoRoute(
                    path: PhotoPulseCamera.routeName.removeLeadingSlash,
                    builder: (context, state) => const PhotoPulseCamera(),
                    routes: [
                      GoRoute(
                        path: ReviewPhotoPage.routeName.removeLeadingSlash,
                        builder: (context, state) => ReviewPhotoPage(
                          isFromGallery:
                              state.pathParameters['param'] == 'true',
                        ),
                        routes: [
                          GoRoute(
                            path: PostPage.routeName.removeLeadingSlash,
                            builder: (context, state) => PostPage(
                              post: state.extra as Post?,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GoRoute(
                    path: ReviewPhotoPage.routeName.removeLeadingSlash,
                    builder: (context, state) => ReviewPhotoPage(
                      isFromGallery: state.pathParameters['param'] == 'true',
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _searchKey,
            routes: [
              GoRoute(
                path: SearchPostsPage.routeName,
                builder: (context, state) => const SearchPostsPage(),
                routes: const [],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _profileKey,
            routes: [
              GoRoute(
                path: ProfilePage.routeName,
                builder: (context, state) => const ProfilePage(),
                routes: [
                  GoRoute(
                    path: AdminPage.routeName.removeLeadingSlash,
                    builder: (context, state) => const AdminPage(),
                  ),
                  GoRoute(
                    path:
                        SubscriptionManagementPage.routeName.removeLeadingSlash,
                    builder: (context, state) =>
                        const SubscriptionManagementPage(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: LoginPage.routeName,
        builder: (context, state) => LoginPage(),
        routes: [
          GoRoute(
            path: ResetPasswordPage.routeName.removeLeadingSlash,
            builder: (context, state) => const ResetPasswordPage(),
          ),
          GoRoute(
            path: RegistrationPage.routeName.lastPart,
            builder: (context, state) => const RegistrationPage(),
            routes: [
              GoRoute(
                path: VerifyEmailPage.routeName.removeLeadingSlash,
                builder: (context, state) => const VerifyEmailPage(),
              ),
            ],
          ),
        ],
      ),
    ];
