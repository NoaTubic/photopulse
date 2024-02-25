import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/data/firebase_error_resolver.dart';
import 'package:photopulse/common/data/firestore/firestore_collections.dart';
import 'package:photopulse/features/admin/domain/entities/log_entry.dart';
import 'package:q_architecture/q_architecture.dart';

final logsRepositoryProvider = Provider<LogsRepository>(
  (ref) => LogsRepositoryImpl(),
);

abstract class LogsRepository {
  StreamFailureOr<List<LogEntry>> getLogs();
}

class LogsRepositoryImpl implements LogsRepository {
  final _logsCollection = FirestoreCollections.logsCollection;

  LogsRepositoryImpl();

  @override
  StreamFailureOr<List<LogEntry>> getLogs() {
    return _logsCollection.snapshots().map(
      (snapshot) {
        try {
          final logs = snapshot.docs.map((doc) => doc.data()).toList();
          return Right(logs);
        } catch (exception) {
          return Left(const FirebaseErrorResolver().resolve(exception));
        }
      },
    );
  }
}
