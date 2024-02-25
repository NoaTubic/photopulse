import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photopulse/common/data/services/permission_handler_service.dart';
import 'package:photopulse/features/auth/data/repository/users_repository.dart';
import 'package:photopulse/features/camera/data/image_gallery_service.dart';
import 'package:q_architecture/base_state_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

final profilePictureNotifierProvider =
    BaseStateNotifierProvider<ProfilePictureNotifier, void>(
  (ref) => ProfilePictureNotifier(
    ref.read(usersRepositoryProvider),
    ref.watch(imageGalleryServiceProvider),
    ref.watch(permissionsHandlerServiceProvider),
    ref,
  ),
);

class ProfilePictureNotifier extends BaseStateNotifier<void> {
  final UsersRepository _usersRepository;
  final ImageGalleryService _galleryService;
  final PermissionsHandlerService _permissionsHandlerService;

  ProfilePictureNotifier(
    this._usersRepository,
    this._galleryService,
    this._permissionsHandlerService,
    super.ref,
  );

  Future<void> changeProfilePicture({String? userId}) async {
    await _permissionsHandlerService.requestPermission(
      onPermissionGranted: () async {
        showGlobalLoading();
        final pickedFile = await _galleryService.loadImage();
        pickedFile.fold(
          (failure) => state = BaseError(failure),
          (content) async {
            await _usersRepository.changeProfilePicture(content.path, userId);
            state = const BaseData(null);
          },
        );
        clearGlobalLoading();
      },
      onPermissionDenied: () {
        BaseError(Failure.permissionDenied());
      },
      permission: await _getPermission(),
    );
  }

  Future<void> removeProfilePicture({String? userId}) async {
    execute(
      _usersRepository.removeProfilePicture(
        userId,
      ),
    );
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
}
