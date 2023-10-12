// ignore_for_file: always_use_package_imports

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/paginated_notifier.dart';

import '../../../data/repositories/example_repository.dart';

final paginatedNotifierProvider = StateNotifierProvider.autoDispose<
    ExamplePaginatedNotifier, PaginatedState<String>>(
  (ref) => ExamplePaginatedNotifier(
    ref.read(exampleRepositoryProvider),
    ref,
  )..getInitialList(),
);

class ExamplePaginatedNotifier extends PaginatedNotifier<String, Object> {
  final ExampleRepository _repository;

  ExamplePaginatedNotifier(this._repository, Ref ref)
      : super(ref, const PaginatedState.loading());

  @override
  PaginatedEitherFailureOr<String> getListOrFailure(
    int page, [
    Object? parameter,
  ]) =>
      _repository.getPaginatedResult(page);
}
