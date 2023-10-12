// ignore_for_file: prefer-match-file-name

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

enum AppTrackingTransparencyStatus {
  notDetermined,
  restricted,
  denied,
  authorized
}

final appTrackingTransparencyChannelProvider =
    Provider<AppTrackingTransparencyChannel>(
  (ref) => AppTrackingTransparencyChannel(),
);

class AppTrackingTransparencyChannel {
  static const platformChannel = MethodChannel('base/tracking');

  Future<AppTrackingTransparencyStatus?> requestTracking() async {
    if (Platform.isIOS) {
      try {
        final rawStatus = await platformChannel.invokeMethod('requestTracking');
        final status = AppTrackingTransparencyStatus.values[rawStatus ?? 0];
        logDebug('Tracking status: $status');
        return status;
      } on PlatformException catch (error, stackTrace) {
        logDebug('TrackingChannel PlatformException: $error, $stackTrace');
      }
    }
    return null;
  }
}
