import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isar/isar.dart';
import 'package:photopulse/features/post/domain/entities/author.dart';
import 'package:photopulse/features/post/domain/entities/post.dart';

part 'post_isar_model.g.dart';

@collection
class PostIsarModel {
  Id? id;
  String? title;
  String? caption;
  AuthorIsarModel? author;
  DateTime? createdAt;
  List<String>? tags;
  String? url;
  double? sizeInMB;

  PostIsarModel(
    this.id, {
    this.title,
    this.caption,
    this.author,
    this.createdAt,
    this.tags,
    this.url,
    this.sizeInMB,
  });
}

@embedded
class AuthorIsarModel {
  String? id;
  String? username;
  String? email;
  String? photoUrl;

  AuthorIsarModel({
    this.id,
    this.username,
    this.email,
    this.photoUrl,
  });
}

PostIsarModel postToIsar(Post post) => PostIsarModel(
      null,
      title: post.title,
      caption: post.caption,
      author: AuthorIsarModel(
        id: post.author.id,
        username: post.author.username,
        email: post.author.email,
        photoUrl: post.author.photoUrl,
      ),
      createdAt: post.createdAt.toDate(),
      tags: post.tags,
      url: post.url,
      sizeInMB: post.sizeInMB,
    );

Post postFromIsar(PostIsarModel model) => Post(
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
