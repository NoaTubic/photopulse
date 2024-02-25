import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photopulse/features/post/data/models/post_isar_model.dart';

abstract class BaseLocalDataSource<T> {
  @protected
  late Future<Isar> db;

  BaseLocalDataSource() {
    db = _initDb();
  }

  Future<void> insertOrUpdate(T model);

  Future<void> insertOrUpdateMultiple(List<T> models);

  Future<void> deleteAllByUserId(int userId) async => {};

  @protected
  Future<R> modify<R>(Future<R> Function(Isar db) function) async {
    final isar = await db;
    return isar.writeTxn(() {
      return function(isar);
    });
  }

  @protected
  Future<T?> readNullable(Future<T?> Function(Isar db) function) async {
    final isar = await db;
    return function(isar);
  }

  @protected
  Future<List<T>> readMultiple(
    Future<List<T>> Function(Isar db) function,
  ) async {
    final isar = await db;
    return function(isar);
  }

  Future<Isar> _initDb() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return Isar.open(
        [PostIsarModelSchema],
        inspector: true,
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }
}
