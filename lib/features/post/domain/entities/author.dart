import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photopulse/features/auth/domain/entities/user.dart';

part 'author.g.dart';

@JsonSerializable()
class Author {
  final String id;
  final String username;
  final String email;
  final String photoUrl;

  Author({
    required this.id,
    required this.username,
    required this.email,
    required this.photoUrl,
  });

  factory Author.fromUser(PhotoPulseUser user) {
    return Author(
      id: user.id,
      username: user.username,
      email: user.email,
      photoUrl: user.photoUrl ?? '',
    );
  }

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}
