// ignore_for_file: always_use_package_imports
import 'package:q_architecture/q_architecture.dart';

import '../../generated/l10n.dart';

final class GenericErrorResolver implements ErrorResolver {
  final String? failureTitle;

  const GenericErrorResolver({this.failureTitle});

  @override
  Failure resolve<T>(Object err, [StackTrace? stackTrace]) {
    final message = err is String ? err : S.current.unknown_error_occurred;
    return Failure.generic(
      title: failureTitle ?? message,
      error: err,
      stackTrace: stackTrace,
    );
  }
}
