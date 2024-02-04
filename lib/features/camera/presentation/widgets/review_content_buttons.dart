import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/body_text.dart';
import 'package:photopulse/features/camera/domain/notifiers/camera_notifier.dart';
import 'package:photopulse/theme/app_colors.dart';

class ReviewContentButtons extends ConsumerWidget {
  const ReviewContentButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGallery = ref.watch(cameraNotifierProvider).content != null;
    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      padding: const EdgeInsets.only(
        left: AppSizes.bodyPaddingHorizontal,
        right: AppSizes.bodyPaddingHorizontal,
        bottom: AppSizes.mediumSpacing,
      ),
      color: AppColors.black,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: TextButton(
              onPressed: () {
                if (isGallery) {
                  ref.read(cameraNotifierProvider.notifier).retakeContent();
                }

                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.white,
              ),
              child: BodyText(
                isGallery ? 'Cancel' : 'Retake',
              ),
            ),
          ),
          Flexible(
            child: SizedBox(
              width: 160,
              height: 40,
              child: FilledButton(
                onPressed: () async {
                  // Navigator.of(context).pushNamed(
                  //   PostPage.routeName,
                  //   arguments: cameraState.isVideo
                  //       ? FamilyPost.onlyVideo(
                  //           cameraState.content?.path ?? '',
                  //           thumbnail: await VideoThumbnail.thumbnailData(
                  //             video: cameraState.content?.path ?? '',
                  //           ),
                  //         )
                  //       : FamilyPost.onlyPhoto(
                  //           cameraState.content?.path ?? '',
                  //           thumbnailUrl: cameraState.content?.path ?? '',
                  //         ),
                  // );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.black,
                  side: BorderSide(
                    color: AppColors.white,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Row(
                  children: [
                    BodyText(
                      'Create post',
                      color: AppColors.white,
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios_rounded),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
