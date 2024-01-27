import 'package:photopulse/features/auth/data/repository/auth_repository.dart';
import 'package:photopulse/features/auth/domain/entities/github_auth_parameters.dart';
import 'package:q_architecture/base_state_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

final githubAuthNotifierProvider =
    BaseStateNotifierProvider<GithubAuthNotifier, void>(
  (ref) => GithubAuthNotifier(
    ref.read(authRepositoryProvider),
    ref,
  ),
);

class GithubAuthNotifier extends BaseStateNotifier<void> {
  final AuthRepository _authRepository;
  GithubAuthNotifier(this._authRepository, super.ref);

  Future<void> loginWithGitHub({
    required GithubAuthParameters parameters,
    required String code,
  }) =>
      execute(
        _authRepository.loginWithGitHub(
          parameters: parameters,
          code: code,
        ),
        onFailureOccurred: (failure) {
          state = BaseState.error(failure);
          return false;
        },
      );

  // Future<NavigationActionPolicy> handleCodeResponse(
  //   NavigationAction navigationAction,
  // ) async {
  //   try {
  //     final bool startWithRedirectUrl = navigationAction.request.url
  //         .toString()
  //         .startsWith(githubAuthParameters.redirectUrl);
  //     final bool hasCodeParam =
  //         Uri.parse(navigationAction.request.url.toString())
  //                 .queryParameters['code'] !=
  //             null;

  //     if (hasCodeParam && startWithRedirectUrl) {
  //       await loginWithGitHub(
  //         parameters: githubAuthParameters,
  //         code: Uri.parse(navigationAction.request.url.toString())
  //             .queryParameters['code']!,
  //       );
  //       return NavigationActionPolicy.CANCEL;
  //     } else {
  //       return NavigationActionPolicy.ALLOW;
  //     }
  //   } catch (e) {
  //     return NavigationActionPolicy.ALLOW;
  //   }
  // }

  void cancelGithubAuth() {
    state = const BaseState.error(
      Failure(title: 'User cancelled'),
    );
  }
}
