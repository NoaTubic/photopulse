import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:photopulse/common/constants/firebase_constants.dart';

import 'package:photopulse/generated/l10n.dart';
import 'package:q_architecture/q_architecture.dart';

final class FirebaseErrorResolver implements ErrorResolver {
  final String? failureTitle;

  const FirebaseErrorResolver({this.failureTitle});

  @override
  Failure resolve<T>(Object err, [StackTrace? stackTrace]) {
    final message = err is PlatformException
        ? err.message
        : (err as FirebaseAuthException).code;
    switch (message) {
      case FirebaseConstants.invalidLoginCredentials:
        return Failure.generic(
          title: failureTitle ?? S.current.login_error_wrong_credentials,
          error: err,
          stackTrace: stackTrace,
        );
      case FirebaseConstants.accountAlreadyExistsError:
        return Failure.generic(
          title: failureTitle ?? S.current.login_error_email_already_in_user,
          error: err,
          stackTrace: stackTrace,
        );
      case FirebaseConstants.userNotFoundError:
        return Failure.generic(
          title: failureTitle ?? S.current.login_error_wrong_credentials,
          error: err,
          stackTrace: stackTrace,
        );
      case FirebaseConstants.wrongPasswordError:
        return Failure.generic(
          title: failureTitle ?? S.current.login_error_wrong_credentials,
          error: err,
          stackTrace: stackTrace,
        );
      default:
        return Failure.generic(
          title: S.current.server_error,
          error: err,
          stackTrace: stackTrace,
        );
    }
  }
}
