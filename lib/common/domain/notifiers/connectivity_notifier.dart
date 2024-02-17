import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/utils/connection_status.dart';

final connectivityProvider =
    StateNotifierProvider<ConnectivityNotifier, ConnectionStatus>(
  (ref) => ConnectivityNotifier(Connectivity())..init(),
);

class ConnectivityNotifier extends StateNotifier<ConnectionStatus> {
  final Connectivity _connectivity;

  ConnectivityNotifier(this._connectivity) : super(ConnectionStatus.undefined);

  void init() => _connectivity.onConnectivityChanged.listen(
        (connectivityResult) {
          final isConnected = connectivityResult == ConnectivityResult.wifi ||
              connectivityResult == ConnectivityResult.mobile;
          state =
              isConnected ? ConnectionStatus.online : ConnectionStatus.offline;
        },
      );
}
