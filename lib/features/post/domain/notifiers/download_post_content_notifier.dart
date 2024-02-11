import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photopulse/common/data/services/permission_handler_service.dart';
import 'package:photopulse/features/post/data/repositories/post_repository.dart';
import 'package:q_architecture/base_state_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

final downloadPostContentNotifierProvider = BaseStateNotifierProvider.family<
    DownloadPostContentNotifier, BaseState<void>, String>(
  (ref, id) => DownloadPostContentNotifier(
    ref.watch(postRepositoryProvider),
    ref.watch(permissionsHandlerServiceProvider),
    ref,
  ),
);

class DownloadPostContentNotifier extends BaseStateNotifier<void> {
  final PostRepository _postRepository;
  final PermissionsHandlerService _permissionsHandlerRepository;

  DownloadPostContentNotifier(
    this._postRepository,
    this._permissionsHandlerRepository,
    super.ref,
  );

  Future<void> downloadContent({
    required String url,
    required String title,
  }) async {
    final permission = await _getPermission();
    await _permissionsHandlerRepository.requestPermission(
      onPermissionGranted: () {
        state = const BaseState.loading();
        showGlobalLoading();
        execute(_postRepository.saveImage(url: url));
      },
      onPermissionDenied: () => state = BaseState.error(
        Failure.generic(
          title: Platform.isAndroid
              ? 'For downloading post content, please allow the Care Connect app to access your gallery and storage.'
              : 'For downloading post content, please allow the Care Connect app to access your gallery.',
        ),
      ),
      permission: permission,
    );
  }

  Future<Permission> _getPermission() async {
    if (!Platform.isAndroid) {
      return Permission.photos;
    }
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt <= 32) {
      return Permission.storage;
    } else {
      return Permission.photos;
    }
  }
}
