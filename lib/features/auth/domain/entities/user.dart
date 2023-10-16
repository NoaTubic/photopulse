import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String username;
  final String email;
  final String photoUrl;
  final bool isAdmin;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.photoUrl,
      required this.isAdmin});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
