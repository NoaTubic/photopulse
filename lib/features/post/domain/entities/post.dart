import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:photopulse/features/post/data/models/post_isar_model.dart';
import 'package:photopulse/features/post/domain/entities/author.dart';

class Post extends Equatable {
  final String? id;
  final String title;
  final String caption;
  @JsonKey(includeToJson: true)
  final Author author;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final Timestamp createdAt;
  final List<String> tags;
  final String url;
  final double sizeInMB;

  const Post({
    this.id,
    required this.title,
    required this.caption,
    required this.author,
    required this.createdAt,
    required this.tags,
    required this.url,
    required this.sizeInMB,
  });

  Post copyWith({
    String? id,
    String? title,
    String? caption,
    Author? author,
    Timestamp? createdAt,
    List<String>? tags,
    String? url,
    double? sizeInMB,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      caption: caption ?? this.caption,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
      tags: tags ?? this.tags,
      url: url ?? this.url,
      sizeInMB: sizeInMB ?? this.sizeInMB,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        caption,
        author,
        createdAt,
        tags,
        url,
      ];

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'] as String,
        title: json['title'] as String,
        caption: json['caption'] as String,
        author: Author.fromJson(json['author']),
        createdAt: json['createdAt'] as Timestamp,
        tags: List<String>.from(json['tags'] ?? []),
        url: json['url'] as String,
        sizeInMB: json['sizeInMB'] as double,
      );

  Map<String, dynamic> toJson(Post post) => <String, dynamic>{
        'id': post.id,
        'title': post.title,
        'caption': post.caption,
        'author': post.author.toJson(),
        'createdAt': post.createdAt,
        'tags': post.tags,
        'url': post.url,
        'sizeInMB': post.sizeInMB,
      };

  static Timestamp _timestampFromJson(int json) =>
      const TimestampConverter().fromJson(json);

  static int _timestampToJson(Timestamp timestamp) =>
      const TimestampConverter().toJson(timestamp);

  @override
  String toString() {
    return 'Post\n id: $id\n title: $title\n caption: $caption\n author: $author\n createdAt: $createdAt\n tags: $tags\n url: $url\n sizeInMB: $sizeInMB';
  }

  factory Post.postFromIsar(PostIsarModel model) => Post(
      id: model.id!.toString(),
      title: model.title!,
      caption: model.caption!,
      author: Author(
        id: model.author!.id!,
        username: model.author!.username!,
        email: model.author!.email!,
        photoUrl: model.author!.photoUrl!,
      ),
      createdAt: Timestamp.fromDate(model.createdAt!),
      tags: model.tags!,
      url: model.url!,
      sizeInMB: model.sizeInMB!);
}

class TimestampConverter implements JsonConverter<Timestamp, int> {
  const TimestampConverter();

  @override
  Timestamp fromJson(int json) {
    return Timestamp(json ~/ 1000, (json % 1000) * 1000000);
  }

  @override
  int toJson(Timestamp object) {
    return object.millisecondsSinceEpoch;
  }
}

final timestampRequest = <String, dynamic>{
  'timestamp': Timestamp.now(),
};
