// ignore_for_file: always_use_package_imports

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/paginated_notifier.dart';

import '../../../data/repositories/example_repository.dart';

final paginatedStreamNotifierProvider = StateNotifierProvider.autoDispose<
    ExamplePaginatedStreamNotifier, PaginatedState<String>>(
  (ref) => ExamplePaginatedStreamNotifier(
    ref.read(exampleRepositoryProvider),
    ref,
  )..getInitialList(),
);

class ExamplePaginatedStreamNotifier
    extends PaginatedStreamNotifier<String, Object> {
  final ExampleRepository _repository;

  ExamplePaginatedStreamNotifier(this._repository, Ref ref)
      : super(ref, const PaginatedState.loading());
  @override
  PaginatedStreamFailureOr<String> getListStreamOrFailure(
    int page, [
    Object? parameter,
  ]) =>
      _repository.getPaginatedStreamResult(page);
}
