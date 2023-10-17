import 'package:q_architecture/q_architecture.dart';

abstract interface class ErrorResolver {
  Failure resolve<T>(Object error, [StackTrace? stackTrace]);
}
