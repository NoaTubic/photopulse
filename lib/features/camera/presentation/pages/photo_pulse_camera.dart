import 'package:another_flushbar/flushbar.dart';
import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/hooks/app_lifecycle_hook.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_icon_button.dart';
import 'package:photopulse/common/presentation/dialogs/permission_dialog.dart';
import 'package:photopulse/features/camera/domain/notifiers/camera_notifier.dart';
import 'package:photopulse/features/camera/domain/notifiers/camera_state.dart';
import 'package:photopulse/features/camera/presentation/widgets/camera_aspect_ratio.dart';
import 'package:photopulse/features/camera/presentation/widgets/camera_button.dart';
import 'package:photopulse/features/navbar/domain/notifiers/nav_bar_visibility_provider.dart';

import 'package:photopulse/theme/app_colors.dart';
import 'package:q_architecture/q_architecture.dart';

class PhotoPulseCamera extends HookConsumerWidget {
  static const routeName = Pages.camera;
  const PhotoPulseCamera({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cameraNotifierProvider);
    final cameraNotifier = ref.read(cameraNotifierProvider.notifier);

    useAppLifecycle(
      onInitialize: () => cameraNotifier.initCamera(),
      onAppOpen: () {
        if (state.failure == Failure.permissionDenied()) {
          cameraNotifier.resetPermissionRequest();
          ref.read(cameraNotifierProvider.notifier).initCamera();
        }
      },
    );

    ref.listen<CameraState>(
      cameraNotifierProvider,
      (previous, next) {
        if (next.failure == Failure.permissionDenied() &&
            next.permissionRequested) {
          cameraNotifier.resetPermissionRequest();
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => PermissionsDialog(
              errorText:
                  'For taking photos, please allow the PhotoPulse app access to your camera.',
              helperText:
                  'Go to your settings > Permissions and turn on the camera.',
              icon: Icons.camera_alt_rounded,
              onPop: () => cameraNotifier.disposeCamera(),
            ),
          );
        } else if (next.failure != null) {
          Flushbar(
            icon: Icon(
              Icons.info_outline_rounded,
              color: AppColors.primaryDefault,
            ),
            messageColor: AppColors.primaryDefault,
            backgroundColor: AppColors.graysUltraLight,
            message: next.failure!.title,
            duration: const Duration(seconds: 3),
          ).show(context);
          cameraNotifier.resetFailure();
        }
      },
    );
    return Stack(
      children: [
        state.isControllerInitialized
            ? Positioned.fill(
                child: CameraPreview(
                  ref.read(cameraNotifierProvider).controller!,
                ),
              )
            : Center(
                child: Container(
                  color: AppColors.black,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
        Positioned.fill(
          top: AppSizes.bodyPaddingVertical,
          left: AppSizes.bodyPaddingHorizontal,
          child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                ref
                    .read(navBarVisibilityProvider.notifier)
                    .toggleNavBarVisibility();
                ref.pop();
                cameraNotifier.disposeCamera();
              },
              icon: Icon(
                Icons.close_rounded,
                color: AppColors.white,
                size: 32,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            ignoring: !state.isControllerInitialized,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.13,
                color: AppColors.black.withOpacity(0.3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PhotoPulseIconButton(
                      onTap: () => cameraNotifier.toggleFlash(),
                      icon: state.isFlashOn ? Icons.flash_off : Icons.flash_on,
                      iconColor: AppColors.white,
                      backgroundColor: Colors.transparent,
                      width: 44,
                      height: 44,
                    ),
                    const CameraButton(),
                    PhotoPulseIconButton(
                      onTap: () => cameraNotifier.switchCamera(),
                      icon: Icons.refresh,
                      iconColor: AppColors.white,
                      backgroundColor: Colors.transparent,
                      width: 44,
                      height: 44,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
