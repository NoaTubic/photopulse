import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/body_text.dart';
import 'package:photopulse/theme/app_colors.dart';

class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final bool withBorder;
  final bool withChangeAndRemoveButton;
  final Function()? onRemoveTap;
  final Function()? onChangeTap;

  const UserAvatar(
    this.imageUrl, {
    this.width,
    this.height,
    this.withBorder = false,
    super.key,
    this.withChangeAndRemoveButton = false,
    this.onRemoveTap,
    this.onChangeTap,
  });

  void get withUploadButtons {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl ?? '',
            width: width,
            height: height,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // placeholder: (context, url) => const BaseLoadingWidget(
            //   child: CircleAvatar(
            //     radius: AppSizes.normalSpacing,
            //   ),
            // ),
            errorWidget: (context, url, error) => Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                border: Border.all(color: AppColors.black),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: Image.file(
                  File(url),
                  fit: BoxFit.fitWidth,
                  errorBuilder: (
                    BuildContext context,
                    Object exception,
                    StackTrace? stackTrace,
                  ) {
                    return FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Icon(
                        Icons.person_rounded,
                        color: AppColors.accentDark,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          if (withChangeAndRemoveButton) ...[
            const SizedBox(
              height: AppSizes.normalSpacing,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onChangeTap,
                  child: BodyText(
                    'Change profile image',
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(
                  width: AppSizes.mediumSpacing,
                ),
                GestureDetector(
                  onTap: onRemoveTap,
                  child: BodyText(
                    'Remove profile image',
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
