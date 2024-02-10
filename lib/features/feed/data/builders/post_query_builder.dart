import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/data/firestore/firestore_collections.dart';

final postQueryBuilderProvider = Provider<PostQueryBuilder>((ref) {
  return FirestorePostQueryBuilder(FirestoreCollections.postsCollection);
});

abstract class PostQueryBuilder {
  void addHashtagFilter(String hashtags);
  void addSizeFilter(double? minSizeMb, double? maxSizeMb);
  void addDateTimeRangeFilter(DateTimeRange? dateTimeRange);
  void addAuthorFilter(String? authorId);
  Query build();
}

class FirestorePostQueryBuilder implements PostQueryBuilder {
  Query _query;

  FirestorePostQueryBuilder(this._query);

  @override
  void addHashtagFilter(String hashtag) {
    // _query = _query.where('tags', arrayContainsAny: [hashtag]);
  }

  @override
  void addSizeFilter(double? minSizeMb, double? maxSizeMb) {
    if (minSizeMb != null) {
      _query = _query.where('imageSizeMb', isGreaterThanOrEqualTo: minSizeMb);
    }
    if (maxSizeMb != null) {
      _query = _query.where('imageSizeMb', isLessThanOrEqualTo: maxSizeMb);
    }
  }

  @override
  void addDateTimeRangeFilter(DateTimeRange? dateTimeRange) {
    if (dateTimeRange != null) {
      _query = _query
          .where('createdAt',
              isGreaterThanOrEqualTo: Timestamp.fromDate(dateTimeRange.start))
          .where('createdAt',
              isLessThanOrEqualTo: Timestamp.fromDate(dateTimeRange.end));
    }
  }

  @override
  void addAuthorFilter(String? authorId) {
    if (authorId != null) {
      _query = _query.where('author.id', isEqualTo: authorId);
    }
  }

  @override
  Query build() {
    return _query;
  }
}
