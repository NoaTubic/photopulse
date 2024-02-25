import 'package:photopulse/generated/l10n.dart';

enum ConnectionStatus {
  undefined,
  online,
  offline;

  String get newStatusMessage {
    if (this == offline) return S.current.you_are_offline;
    return S.current.back_online;
  }
}
