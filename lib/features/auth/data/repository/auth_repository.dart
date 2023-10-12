// ignore_for_file: always_use_package_imports
import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

import '../../../../common/data/generic_error_resolver.dart';

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepositoryImpl());

abstract interface class AuthRepository {
  EitherFailureOr<void> login({
    required String email,
    required String password,
  });

  EitherFailureOr<String?> getTokenIfAuthenticated();
}

class AuthRepositoryImpl with ErrorToFailureMixin implements AuthRepository {
  @override
  EitherFailureOr<String?> getTokenIfAuthenticated() => execute(
        () async {
          await 1.seconds;
          return const Right(null);
        },
        errorResolver: const GenericErrorResolver(),
      );

  @override
  EitherFailureOr<void> login({
    required String email,
    required String password,
  }) =>
      execute(
        () async {
          await 1.seconds;
          return const Right(null);
        },
        errorResolver: const GenericErrorResolver(),
      );
}
