import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:photopulse/common/data/services/base_local_db_service.dart';
import 'package:photopulse/features/post/data/models/post_isar_model.dart';
import 'package:photopulse/features/post/domain/entities/post.dart';

final postsLocalDataSourceProvider = Provider(
  (ref) => PostsLocalDataSource(),
);

class PostsLocalDataSource extends BaseLocalDataSource<PostIsarModel> {
  Future<void> cacheLatestPosts(List<PostIsarModel> models) async {
    final currentPosts =
        await readMultiple((db) => db.postIsarModels.where().findAll());
    final List<int> ids = currentPosts.map((post) => post.id!).toList();
    await deleteAllPosts(ids);
    await insertOrUpdateMultiple(models);
  }

  @override
  Future<void> insertOrUpdate(PostIsarModel model) async {
    await modify(
      (db) => db.postIsarModels.put(model),
    );
  }

  Future<List<Post>> getCachedPosts() async {
    final posts =
        await readMultiple((db) => db.postIsarModels.where().findAll());
    return posts.map((post) => Post.postFromIsar(post)).toList();
  }

  @override
  Future<void> insertOrUpdateMultiple(List<PostIsarModel> models) async {
    await modify(
      (db) => db.postIsarModels.putAll(models),
    );
  }

  Future<void> deleteAllPosts(List<int> postIds) => modify(
        (db) => db.postIsarModels.deleteAll(postIds),
      );
}
