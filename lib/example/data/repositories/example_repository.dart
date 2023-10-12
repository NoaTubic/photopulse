// ignore_for_file: always_use_package_imports

import 'dart:math';

import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/paginated_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

import '../../../common/data/api_client.dart';
import '../../../common/data/providers.dart';
import '../../domain/entities/example_user.dart';
import '../mappers/example_user_entity_mapper.dart';
import '../models/example_user_response.dart';

final exampleRepositoryProvider = Provider<ExampleRepository>(
  (ref) => ExampleRepositoryImp(
    ref.watch(apiClientProvider),
    ref.watch(exampleUserEntityMapperProvider),
  ),
);

abstract class ExampleRepository {
  EitherFailureOr<String> getSomeString();

  EitherFailureOr<String> getSomeOtherString();

  StreamFailureOr<String> getSomeStringsStreamed();

  EitherFailureOr<ExampleUser> apiCallExample();

  PaginatedStreamFailureOr<String> getPaginatedStreamResult(int page);

  PaginatedEitherFailureOr<String> getPaginatedResult(int page);
}

class ExampleRepositoryImp implements ExampleRepository {
  final ApiClient _apiClient;
  final EntityMapper<ExampleUser, ExampleUserResponse> _userMapper;
  var _counter = 0;

  ExampleRepositoryImp(
    this._apiClient,
    this._userMapper,
  );

  @override
  EitherFailureOr<ExampleUser> apiCallExample() async {
    try {
      final userResponse = await _apiClient.getUser();
      final user = _userMapper(userResponse);
      return Right(user);
    } catch (error, stackTrace) {
      return Left(
        Failure.generic(error: error, stackTrace: stackTrace),
      );
    }
  }

  @override
  EitherFailureOr<String> getSomeOtherString() async {
    await 3.seconds;
    if (Random().nextBool()) {
      return Right(Random().nextBool() ? 'Some sentence' : '');
    } else {
      return Left(Failure.generic());
    }
  }

  @override
  StreamFailureOr<String> getSomeStringsStreamed() async* {
    yield const Right('Some sentence from cache');

    await 3.seconds;
    yield const Right('Some sentence from network');
  }

  @override
  EitherFailureOr<String> getSomeString() async {
    await 3.seconds;
    if (Random().nextBool()) {
      return const Right('some sentence');
    } else {
      return Left(Failure.generic());
    }
  }

  @override
  PaginatedStreamFailureOr<String> getPaginatedStreamResult(int page) async* {
    if (page == 1) {
      _counter = 0;
    }
    List<String>? someStrings;
    if (page == 1) {
      someStrings = _getStrings();
      yield Right(PaginatedList(data: someStrings, isLast: false, page: 1));
    }
    await 3.seconds;
    if (Random().nextBool()) {
      yield Right(
        PaginatedList(
          data: someStrings ?? _getStrings(),
          isLast: page == 4,
          page: page,
        ),
      );
    } else {
      yield Left(Failure.generic());
    }
  }

  @override
  PaginatedEitherFailureOr<String> getPaginatedResult(int page) async {
    await 3.seconds;
    if (Random().nextBool()) {
      if (page == 1) {
        _counter = 0;
      }
      return Right(
        PaginatedList(
          data: _getStrings(),
          isLast: page == 4,
          page: page,
        ),
      );
    }
    return Left(Failure.generic());
  }

  List<String> _getStrings() => [
        '${++_counter}',
        '${++_counter}',
        '${++_counter}',
        '${++_counter}',
        '${++_counter}',
        '${++_counter}',
        '${++_counter}',
        '${++_counter}',
        '${++_counter}',
        '${++_counter}',
      ];
}
