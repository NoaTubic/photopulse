import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/notifiers/connectivity_notifier.dart';
import 'package:photopulse/common/domain/utils/connection_status.dart';

extension ConnectivityExtensions on WidgetRef {
  void globalConnectivityListener() {
    listen(
      connectivityProvider,
      (previousConnectionStatus, newConnectionStatus) {
        if (previousConnectionStatus == ConnectionStatus.undefined &&
            newConnectionStatus == ConnectionStatus.offline) {
          //TODO: add handler
          // ignore: avoid_print
          print(ConnectionStatus.offline.newStatusMessage);
          return;
        }
        //TODO: add handler
        // ignore: avoid_print
        print(newConnectionStatus?.newStatusMessage);
      },
    );
  }
}
