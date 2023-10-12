import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  const factory AuthState.initial() = AuthStateInitial;
  const factory AuthState.authenticating() = AuthStateAuthenticating;
  const factory AuthState.authenticated() = AuthStateAuthenticated;
  const factory AuthState.unauthenticated() = AuthStateUnauthenticated;
}

final class AuthStateInitial extends AuthState {
  const AuthStateInitial();

  @override
  List<Object?> get props => [];
}

final class AuthStateAuthenticating extends AuthState {
  const AuthStateAuthenticating();

  @override
  List<Object?> get props => [];
}

final class AuthStateAuthenticated extends AuthState {
  const AuthStateAuthenticated();

  @override
  List<Object?> get props => [];
}

final class AuthStateUnauthenticated extends AuthState {
  const AuthStateUnauthenticated();

  @override
  List<Object?> get props => [];
}
