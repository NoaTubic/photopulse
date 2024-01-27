//ignore_for_file: avoid-unused-parameters, avoid-returning-widgets
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:photopulse/common/constants/duration_constants.dart';
import 'package:photopulse/common/domain/providers/base_router_provider.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/body_text.dart';
import 'package:photopulse/theme/app_colors.dart';

class PhotoPulseToast extends StatelessWidget {
  final String message;
  const PhotoPulseToast({
    super.key,
    required this.message,
  });

  void show(BuildContext context) =>
      getFlushbar(context).show(rootNavigatorKey.currentState!.context);

  Flushbar getFlushbar(BuildContext context) => Flushbar(
        message: message,
        messageText: Padding(
          padding: const EdgeInsets.only(right: AppSizes.mediumSpacing),
          child: Center(
            child: BodyText(
              message,
              isBold: true,
              color: AppColors.primaryDefault,
            ),
          ),
        ),
        icon: Icon(
          Icons.warning_amber_rounded,
          color: AppColors.primaryDefault,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSizes.normalCircularRadius),
        ),
        maxWidth:
            MediaQuery.of(context).size.width - AppSizes.bodyPaddingHorizontal,
        margin: Platform.isAndroid
            ? const EdgeInsets.only(bottom: AppSizes.xLargeSpacing)
            : EdgeInsets.zero,
        flushbarStyle: FlushbarStyle.FLOATING,
        backgroundColor: AppColors.white,
        duration: DurationConstants.toastDuration,
        isDismissible: true,
        flushbarPosition: FlushbarPosition.BOTTOM,
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      );

  @override
  Widget build(BuildContext context) => getFlushbar(context);
}
