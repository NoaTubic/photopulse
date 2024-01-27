import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oauth2/oauth2.dart';
import 'package:photopulse/common/data/services/local_storage_service.dart';
import 'package:photopulse/features/auth/domain/entities/github_access_token.dart';
import 'package:q_architecture/q_architecture.dart';

final githubAuthenticatorProvider = Provider<GithubAuthenticator>(
  (ref) => GithubAuthenticatorImpl(
    ref.watch(localStorageServiceProvider),
  ),
);

abstract class GithubAuthenticator {
  Future<Credentials?> getSingedInCredentials();
  EitherFailureOr<GithubAccessToken> signInWithGithub();
}

class GithubAuthenticatorImpl implements GithubAuthenticator {
  final LocalStorageService _localStorageService;

  GithubAuthenticatorImpl(this._localStorageService);

  @override
  Future<Credentials?> getSingedInCredentials() async {
    try {
      final storedCredentials =
          await _localStorageService.readOAuth2Credentials();
      if (storedCredentials != null) {
        if (storedCredentials.canRefresh && storedCredentials.isExpired) {
          //TODO: refresh
        }
      }
      return storedCredentials;
    } on PlatformException {
      return null;
    }
  }

  Future<bool> isSignedIn() =>
      getSingedInCredentials().then((credentials) => credentials != null);

  @override
  EitherFailureOr<GithubAccessToken> signInWithGithub() {
    throw UnimplementedError();
  }
}
