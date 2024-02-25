import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/constants/constants.dart';
import 'package:photopulse/features/camera/data/image_converter_service.dart';
import 'package:photopulse/features/camera/domain/notifiers/camera_state.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:image/image.dart' as img;

final cameraNotifierProvider =
    StateNotifierProvider<CameraNotifier, CameraState>(
  (ref) => CameraNotifier(
    ref.watch(imageConverterServiceProvider),
    ref,
  ),
);

class CameraNotifier extends SimpleStateNotifier<CameraState> {
  final ImageConverterService _heicConverterService;

  CameraNotifier(
    this._heicConverterService,
    Ref ref,
  ) : super(ref, CameraState.initial());

  Future<void> initCamera({CameraDescription? camera}) async {
    final List<CameraDescription> cameras = await availableCameras();
    final CameraController controller = CameraController(
      camera ?? cameras.first,
      ResolutionPreset.veryHigh,
      imageFormatGroup: ImageFormatGroup.jpeg,
      enableAudio: false,
    );

    controller.initialize().then(
      (_) {
        controller.lockCaptureOrientation(DeviceOrientation.portraitUp);
        state = state.copyWith(
          controller: controller,
          cameras: cameras,
          isControllerInitialized: true,
          failure: null,
          permissionRequested: true,
        );
      },
    ).catchError((Object e) {
      if (e is CameraException) {
        state = state.copyWith(
          failure: Failure.permissionDenied(),
          isControllerInitialized: false,
          permissionRequested: true,
        );
        switch (e.code) {
          case Constants.cameraAccessDeniedIOS:
            break;
          case Constants.cameraAccessDeniedAndroid:
            break;
          default:
            break;
        }
      }
    });
  }

  void switchCamera() {
    final lensDirection = state.controller!.description.lensDirection;

    CameraDescription camera;

    if (lensDirection == CameraLensDirection.front) {
      camera = _camera(CameraLensDirection.back);
      state = state.copyWith(isSelfie: false);
    } else {
      camera = _camera(CameraLensDirection.front);
      state = state.copyWith(isSelfie: true);
    }

    initCamera(camera: camera);
  }

  void toggleFlash() {
    state.controller!.setFlashMode(
      state.isFlashOn ? FlashMode.off : FlashMode.torch,
    );
    state = state.copyWith(isFlashOn: !state.isFlashOn);
  }

  Future<void> takePicture() async {
    final XFile image = await state.controller!.takePicture();
    await _stopImageStream();

    if (state.isSelfie) {
      final File flippedImage = await _flipImage(File(image.path));
      log('flipped image : ${flippedImage.path}');
      state = state.copyWith(
        content:
            await _heicConverterService.convertHeicOrHeifToJpeg(flippedImage),
      );
    } else {
      state = state.copyWith(
        content: await _heicConverterService
            .convertHeicOrHeifToJpeg(File(image.path)),
      );
    }
  }

  void retakeContent() {
    state = state.copyWith(
      content: null,
    );
  }

  void disposeCamera() {
    if (state.controller != null) {
      state.controller!.dispose();
      state = CameraState.initial();
    }
  }

  Future<void> resetPermissionRequest() async =>
      state = state.copyWith(permissionRequested: false);

  void resetFailure() => state = state.copyWith(failure: null);

  CameraDescription _camera(CameraLensDirection cameraLensDirection) {
    return state.cameras.firstWhere(
      (camera) {
        return camera.lensDirection == cameraLensDirection;
      },
    );
  }

  Future<void> _stopImageStream() async {
    if (state.controller!.value.isStreamingImages) {
      await state.controller?.stopImageStream();
    }
  }
}

Future<File> _flipImage(File imageFile) async {
  final bytes = await imageFile.readAsBytes();
  final image = img.decodeImage(bytes);
  final flippedImage = img.flipHorizontal(image!);
  final flippedBytes = Uint8List.fromList(img.encodePng(flippedImage));
  final flippedFile = await File(imageFile.path).writeAsBytes(flippedBytes);

  return flippedFile;
}
