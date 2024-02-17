enum ConnectionStatus {
  undefined,
  online,
  offline;

  String get newStatusMessage {
    //TODO: add localized strings
    if (this == offline) return 'You are offline';
    return 'You are back online';
  }
}
