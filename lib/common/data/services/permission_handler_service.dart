import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionsHandlerServiceProvider = Provider(
  (_) => PermissionsHandlerServiceImpl(),
);

abstract class PermissionsHandlerService {
  Future requestPermission({
    required Function() onPermissionGranted,
    required Function() onPermissionDenied,
    required Permission permission,
  });

  Future checkPermissionStatus({
    required Function() onPermissionGranted,
    required Function() onPermissionDenied,
    required Permission permission,
  });
}

class PermissionsHandlerServiceImpl implements PermissionsHandlerService {
  PermissionsHandlerServiceImpl();

  @override
  Future requestPermission({
    required Function() onPermissionGranted,
    required Function() onPermissionDenied,
    required Permission permission,
  }) async {
    final status = await permission.request();
    log(status.toString());
    if (status.isGranted) {
      return onPermissionGranted();
    } else {
      return onPermissionDenied();
    }
  }

  @override
  Future checkPermissionStatus({
    required Function() onPermissionGranted,
    required Function() onPermissionDenied,
    required Permission permission,
  }) async {
    final status = await permission.status;
    log(status.toString());
    if (status.isGranted) {
      return onPermissionGranted();
    } else {
      return onPermissionDenied();
    }
  }
}
