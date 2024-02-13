import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/data/firestore/firestore_collections.dart';

final postQueryBuilderProvider = Provider<PostQueryBuilder>((ref) {
  return FirestorePostQueryBuilder(FirestoreCollections.postsCollection);
});

abstract class PostQueryBuilder {
  void addHashtagFilter(String hashtags);
  void addAuthorFilter(String? authorId);
  void sortByDate(bool descending);
  void sortBySize(bool descending);
  void reset();
  Query build();
}

class FirestorePostQueryBuilder implements PostQueryBuilder {
  Query _query;

  FirestorePostQueryBuilder(this._query);

  @override
  void addHashtagFilter(String hashtag) {
    if (hashtag.isNotEmpty) {
      _query = _query.where('tags', arrayContainsAny: [hashtag]);
    }
  }

  @override
  void addAuthorFilter(String? authorId) {
    if (authorId != null) {
      _query = _query.where('author.id', isEqualTo: authorId);
    }
  }

  @override
  void sortByDate(bool descending) {
    _query = _query.orderBy('createdAt', descending: descending);
  }

  @override
  void sortBySize(bool descending) {
    _query = _query.orderBy('sizeInMB', descending: descending);
  }

  @override
  Query build() {
    log(_query.toString());
    return _query;
  }

  @override
  void reset() {
    _query = FirestoreCollections.postsCollection;
  }
}
