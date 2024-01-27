// ignore_for_file: always_use_package_imports
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/auth/domain/notifiers/user_notifier.dart';
import 'package:photopulse/features/auth/presentation/pages/login_page.dart';
import '../../../../common/domain/providers/base_router_provider.dart';
import '../../../home/presentation/home_page.dart';
import '../../data/repository/auth_repository.dart';
import 'auth_state.dart';

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  () => AuthNotifier(),
);

class AuthNotifier extends Notifier<AuthState> implements Listenable {
  late final AuthRepository _authRepository;
  VoidCallback? _routerListener;
  String? _deepLink;

  @override
  AuthState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    return const AuthState.unauthenticated();
  }

  Future<void> listenAuthChanges() async =>
      _authRepository.subscribeToAuthChanges().listen(
        (user) {
          final newState = user != null && user.emailVerified
              ? const AuthState.authenticated()
              : const AuthState.unauthenticated();
          if (state != newState) {
            if (newState is AuthStateAuthenticated) {
              ref.read(userProvider);
            }
            state = newState;
            _routerListener?.call();
          }
        },
      );

  Future<void> logout() async {
    await _authRepository.logout();
    state = const AuthState.unauthenticated();
    _routerListener?.call();
  }

  String? redirect({
    required GoRouterState state,
    required bool showErrorIfNonExistentRoute,
  }) {
    final isAuthenticating = switch (this.state) {
      AuthStateInitial() || AuthStateAuthenticating() => true,
      _ => false,
    };
    if (isAuthenticating) return null;
    final isLoggedIn = switch (this.state) {
      AuthStateAuthenticated() => true,
      _ => false,
    };
    final routeExists =
        ref.read(baseRouterProvider).routeExists(state.matchedLocation);
    final loginRoutes = state.matchedLocation.startsWith(LoginPage.routeName);
    final loggingIn = state.matchedLocation == LoginPage.routeName;
    if (loggingIn) {
      if (isLoggedIn) {
        if (_deepLink != null) {
          final tmpDeepLink = _deepLink;
          _deepLink = null;
          return tmpDeepLink;
        }

        return HomePage.routeName;
      }
      return null;
    }
    if (isLoggedIn && routeExists) {
      return loginRoutes ? HomePage.routeName : null;
    }
    _deepLink = !loginRoutes && routeExists ? state.matchedLocation : null;
    return loginRoutes || (showErrorIfNonExistentRoute && !routeExists)
        ? null
        : LoginPage.routeName;
  }

  @override
  void addListener(VoidCallback listener) => _routerListener = listener;

  @override
  void removeListener(VoidCallback listener) => _routerListener = null;
}
