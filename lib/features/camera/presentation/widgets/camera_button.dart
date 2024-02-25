import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/constants/duration_constants.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/features/camera/domain/notifiers/camera_notifier.dart';
import 'package:photopulse/features/camera/presentation/pages/photo_pulse_camera.dart';
import 'package:photopulse/features/camera/presentation/pages/review_photo_page.dart';
import 'package:photopulse/features/upload_content/presentation/pages/upload_content_page.dart';
import 'package:photopulse/theme/app_colors.dart';

class CameraButton extends HookConsumerWidget {
  const CameraButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraNotifier = ref.read(cameraNotifierProvider.notifier);
    final animationController = useAnimationController(
      duration: DurationConstants.shortAnimationDuration,
    );
    final double animation = useAnimation(
      Tween<double>(begin: 1.0, end: 0.9).animate(animationController),
    );

    return GestureDetector(
      onTapDown: (_) => _onTapDown(animationController),
      onTapUp: (_) => _onTapUp(animationController, cameraNotifier, ref),
      onTapCancel: () => _onTapCancel(animationController),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.fromBorderSide(
            BorderSide(color: AppColors.white, width: 3),
          ),
        ),
        child: Transform.scale(
          scale: animation,
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: Icon(
              Icons.circle,
              size: AppSizes.cameraButtonSize,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}

void _onTapDown(AnimationController animationController) {
  animationController.forward();
}

Future<void> _onTapUp(
  AnimationController animationController,
  CameraNotifier cameraNotifier,
  WidgetRef ref,
) async {
  animationController.reverse();

  await cameraNotifier.takePicture().whenComplete(
    () {
      ref.pushNamed(
        '${UploadContentPage.routeName}${PhotoPulseCamera.routeName}${ReviewPhotoPage.routeName}',
        data: false,
      );
    },
  );
}

void _onTapCancel(
  AnimationController animationController,
) {
  animationController.reverse();
}
