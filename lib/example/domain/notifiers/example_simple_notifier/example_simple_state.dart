// ignore_for_file: always_use_package_imports

import 'package:equatable/equatable.dart';
import 'package:q_architecture/q_architecture.dart';

sealed class ExampleSimpleState extends Equatable {
  const ExampleSimpleState();

  const factory ExampleSimpleState.initial() = ExampleSimpleStateInitial;

  const factory ExampleSimpleState.empty() = ExampleSimpleStateEmpty;

  const factory ExampleSimpleState.fetching() = ExampleSimpleStateFetching;

  const factory ExampleSimpleState.success(String sentence) =
      ExampleSimpleStateSuccess;

  const factory ExampleSimpleState.error(Failure failure) =
      ExampleSimpleStateError;
}

final class ExampleSimpleStateInitial extends ExampleSimpleState {
  const ExampleSimpleStateInitial();

  @override
  List<Object?> get props => [];
}

final class ExampleSimpleStateEmpty extends ExampleSimpleState {
  const ExampleSimpleStateEmpty();

  @override
  List<Object?> get props => [];
}

final class ExampleSimpleStateFetching extends ExampleSimpleState {
  const ExampleSimpleStateFetching();

  @override
  List<Object?> get props => [];
}

final class ExampleSimpleStateSuccess extends ExampleSimpleState {
  final String data;

  const ExampleSimpleStateSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

final class ExampleSimpleStateError extends ExampleSimpleState {
  final Failure failure;

  const ExampleSimpleStateError(this.failure);

  @override
  List<Object?> get props => [failure];
}
