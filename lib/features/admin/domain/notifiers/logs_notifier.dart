import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/admin/data/repositories/logs_repository.dart';
import 'package:photopulse/features/admin/domain/entities/log_entry.dart';

import 'package:q_architecture/q_architecture.dart';

final logsNotifierProvider =
    StateNotifierProvider<LogsNotifier, List<LogEntry>>(
  (ref) => LogsNotifier(
    ref.watch(logsRepositoryProvider),
    ref,
  ).._init(),
);

class LogsNotifier extends SimpleStateNotifier<List<LogEntry>> {
  final LogsRepository _logsRepository;
  StreamSubscription? _logsSubscription;

  LogsNotifier(this._logsRepository, Ref ref) : super(ref, []);

  void _init() {
    _logsSubscription = _logsRepository.getLogs().listen(
      (eitherFailureOrUsers) {
        eitherFailureOrUsers.fold(
          (failure) => state = [],
          (logs) => state = logs,
        );
      },
    );
  }

  @override
  void dispose() {
    _logsSubscription?.cancel();
    super.dispose();
  }
}
