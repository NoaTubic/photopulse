import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/display_text.dart';
import 'package:photopulse/features/feed/presentation/widgets/download_post_content_overlay.dart';
import 'package:photopulse/features/feed/presentation/widgets/image_viewer.dart';
import 'package:photopulse/theme/app_colors.dart';

class FeedImage extends ConsumerWidget {
  final String id;
  final String imageUrl;

  const FeedImage({
    required this.id,
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: AppSizes.imageViewerHeightMax,
        minHeight: AppSizes.imageViewerHeightMin,
      ),
      child: DownloadPostContentOverlay(
        id: id,
        child: ImageViewer(
          imageUrl: imageUrl,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            progressIndicatorBuilder: (context, url, progress) => Container(
              color: AppColors.black.withOpacity(0.1),
              width: double.infinity,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            ),
            errorWidget: (context, url, error) => Image.file(
              File(url),
              fit: BoxFit.fitWidth,
              errorBuilder: (
                BuildContext context,
                Object exception,
                StackTrace? stackTrace,
              ) {
                return const _ImageError();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ImageError extends StatelessWidget {
  const _ImageError();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const DisplayText('Whoops'),
          const SizedBox(
            height: AppSizes.normalSpacing,
          ),
          Icon(
            Icons.error,
            color: AppColors.white,
            size: AppSizes.mediaButtonSize,
          ),
        ],
      ),
    );
  }
}
