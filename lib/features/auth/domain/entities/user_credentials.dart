import 'package:equatable/equatable.dart';

class UserCredentials extends Equatable {
  final String email;
  final String password;

  const UserCredentials({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
