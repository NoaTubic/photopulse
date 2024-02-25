import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photopulse/common/data/firestore/firestore_constants.dart';
import 'package:photopulse/features/admin/domain/entities/log_entry.dart';
import 'package:photopulse/features/auth/domain/entities/user.dart';
import 'package:photopulse/features/post/domain/entities/post.dart';

class FirestoreCollections {
  static final usersCollection = FirebaseFirestore.instance
      .collection(FirestoreConstants.users)
      .withConverter<PhotoPulseUser>(
        fromFirestore: (data, _) => PhotoPulseUser.fromJson(data.data() ?? {}),
        toFirestore: (data, _) => data.toJson(),
      );
  static final postsCollection = FirebaseFirestore.instance
      .collection(FirestoreConstants.posts)
      .withConverter<Post>(
        fromFirestore: (data, _) => Post.fromJson(data.data() ?? {}),
        toFirestore: (data, _) => data.toJson(data),
      );

  static final logsCollection = FirebaseFirestore.instance
      .collection(FirestoreConstants.logs)
      .withConverter<LogEntry>(
        fromFirestore: (data, _) => LogEntry.fromJson(data.data() ?? {}),
        toFirestore: (data, _) => data.toJson(),
      );
}
