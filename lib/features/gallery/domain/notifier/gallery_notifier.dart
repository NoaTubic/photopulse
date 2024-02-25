import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photopulse/common/data/services/permission_handler_service.dart';
import 'package:photopulse/features/camera/data/image_gallery_service.dart';
import 'package:photopulse/features/gallery/domain/notifier/gallery_state.dart';
import 'package:q_architecture/q_architecture.dart';

final galleryNotifierProvider =
    StateNotifierProvider<GalleryNotifier, GalleryState>(
  (ref) => GalleryNotifier(
    ref,
    ref.read(permissionsHandlerServiceProvider),
    ref.read(imageGalleryServiceProvider),
  ),
);

class GalleryNotifier extends SimpleStateNotifier<GalleryState> {
  final PermissionsHandlerServiceImpl _permissionsHandlerService;
  final ImageGalleryService _imageGalleryService;

  GalleryNotifier(
    Ref ref,
    this._permissionsHandlerService,
    this._imageGalleryService,
  ) : super(
          ref,
          GalleryState.initial(),
        );

  Future<void> loadFromGallery() async {
    await _permissionsHandlerService.requestPermission(
      onPermissionGranted: () async {
        showGlobalLoading();
        final pickedFile = await _imageGalleryService.loadImage();
        pickedFile.fold(
          (failure) => state = state.copyWith(failure: failure),
          (content) {
            state = state.copyWith(
              content: content,
            );
          },
        );
        clearGlobalLoading();
      },
      onPermissionDenied: () {
        state = state.copyWith(failure: Failure.permissionDenied());
      },
      permission: await _getPermission(),
    );
  }

  void retakeContent() {
    state = state.copyWith(
      content: null,
    );
  }
}

Future<Permission> _getPermission() async {
  if (Platform.isIOS) return Permission.photos;
  final androidInfo = await DeviceInfoPlugin().androidInfo;
  if (androidInfo.version.sdkInt <= 32) {
    return Permission.storage;
  } else {
    return Permission.photos;
  }
}
