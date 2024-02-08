import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/presentation/photo_pulse_app_bar.dart';
import 'package:photopulse/features/camera/domain/notifiers/camera_notifier.dart';
import 'package:photopulse/features/camera/presentation/widgets/camera_aspect_ratio.dart';
import 'package:photopulse/features/camera/presentation/widgets/review_content_buttons.dart';
import 'package:photopulse/features/gallery/domain/notifier/gallery_notifier.dart';
import 'package:photopulse/theme/app_colors.dart';

class ReviewPhotoPage extends HookConsumerWidget {
  static const routeName = Pages.reviewPhoto;
  final bool isFromGallery;
  const ReviewPhotoPage({super.key, this.isFromGallery = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final File? image = ref.watch(cameraNotifierProvider).content ??
        ref.watch(galleryNotifierProvider).content;

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: PhotoPulseAppBar.withBackNav(
        iconColor: AppColors.white,
        onTap: () {
          if (isFromGallery != true) {
            ref.read(cameraNotifierProvider.notifier).retakeContent();
          }
          Navigator.of(context).pop();
        },
      ),
      body: image != null
          ? Stack(
              children: [
                Positioned.fill(child: Image.file(image)),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: ReviewContentButtons(),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
