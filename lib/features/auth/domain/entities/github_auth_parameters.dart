import 'package:photopulse/features/auth/data/constants/github_auth_constants.dart';

class GithubAuthParameters {
  String clientId;
  String clientSecret;
  String redirectUrl;
  String scopes;

  GithubAuthParameters({
    required this.clientId,
    required this.clientSecret,
    required this.redirectUrl,
    required this.scopes,
  });

  String combinedUrl() {
    return '${GithubAuthConstants.authorizeUrl}?scope=$scopes&client_id=$clientId&redirect_uri=$redirectUrl';
  }
}

final githubAuthParameters = GithubAuthParameters(
  clientId: 'a3c5c6b3c3565338263e',
  clientSecret: 'bccab48fc25b748933479724b58635d4b85deedd',
  redirectUrl: 'https://github.com/NoaTubic/photopulse',
  scopes: 'read:user,user:email',
);
