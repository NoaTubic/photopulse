import 'package:camera/camera.dart';
import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:q_architecture/q_architecture.dart';

part 'camera_state.freezed.dart';

@freezed
class CameraState with _$CameraState {
  const factory CameraState({
    CameraController? controller,
    required bool isControllerInitialized,
    required List<CameraDescription> cameras,
    required bool isSelfie,
    required bool isFlashOn,
    Failure? failure,
    required bool permissionRequested,
    File? content,
  }) = _CameraState;

  factory CameraState.initial() => const CameraState(
        cameras: [],
        isSelfie: false,
        isFlashOn: false,
        isControllerInitialized: false,
        permissionRequested: false,
      );
}
