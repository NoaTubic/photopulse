import 'dart:developer';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:photopulse/common/data/firestore/firestore_collections.dart';
import 'package:photopulse/features/auth/data/repository/users_repository.dart';
import 'package:photopulse/features/post/domain/entities/post.dart';
import 'package:q_architecture/paginated_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepositoryImpl(
    ref.watch(usersRepositoryProvider),
  );
});

abstract class PostRepository {
  EitherFailureOr<void> createPost(Post post);
  EitherFailureOr<void> deletePost(Post post);
  EitherFailureOr<void> updatePost(Post post);
  EitherFailureOr<Post> getPost(String id);
}

class PostRepositoryImpl implements PostRepository {
  final _postsCollection = FirestoreCollections.postsCollection;
  final _firebaseStorage = FirebaseStorage.instance;
  final UsersRepository _usersRepository;

  PostRepositoryImpl(this._usersRepository);

  @override
  EitherFailureOr<void> createPost(Post post) async {
    try {
      await _postsCollection.doc(post.id).set(await _postWithFilePath(post));
      await _usersRepository.incrementDailyUpload();
      return const Right(null);
    } catch (_, st) {
      logDebug(_, st);
      return Left(Failure.generic());
    }
  }

  @override
  EitherFailureOr<void> deletePost(Post post) async {
    try {
      await _postsCollection.doc(post.id).delete();
      return const Right(null);
    } catch (e) {
      return Left(Failure.generic());
    }
  }

  @override
  EitherFailureOr<void> updatePost(Post post) async {
    try {
      final postWithFilePath = await _postWithFilePath(post);
      await _postsCollection.doc(post.id).update(postWithFilePath.toJson(post));
      return const Right(null);
    } catch (e) {
      return Left(Failure.generic());
    }
  }

  @override
  EitherFailureOr<Post> getPost(String id) async {
    try {
      final postDoc = await _postsCollection.doc(id).get();
      final post = postDoc.data();
      if (post == null) {
        return Left(Failure.generic());
      }
      return Right(post);
    } catch (e) {
      return Left(Failure.generic());
    }
  }

  Future<String> storeImage(
    String path,
  ) async {
    final imageRef = _firebaseStorage.ref().child('photos').child(path);
    await imageRef.putFile(File(path));
    final imageUrl = await imageRef.getDownloadURL();
    return imageUrl;
  }

  Future<Post> _postWithFilePath(Post post) async {
    return post.copyWith(
      url: await storeImage(post.url),
    );
  }
}
