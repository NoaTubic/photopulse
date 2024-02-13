import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_text_button.dart';
import 'package:photopulse/common/presentation/text/body_text.dart';
import 'package:photopulse/common/presentation/text/headline_text.dart';
import 'package:photopulse/theme/app_colors.dart';

//ignore_for_file: avoid-ignoring-return-values, prefer-extracting-callbacks
class PhotoPulseDialog extends StatelessWidget {
  final Widget? topWidget;
  final String title;
  final String? bodyText;
  final Widget? body;
  final String? topButtonText;
  final Function()? topButtonAction;
  final String? bottomButtonText;
  final Function()? bottomButtonAction;
  final bool removeBottomBodyPadding;
  final bool showDialogButtons;
  final bool barrierDismissible;
  final bool centerBodyText;
  final bool shouldTopActionPop;
  final EdgeInsets? mainPadding;
  final String? cancelButtonText;
  final Function()? cancelButtonAction;
  final EdgeInsets buttonsPadding;
  final bool? disableBack;

  const PhotoPulseDialog({
    super.key,
    this.topWidget,
    required this.title,
    this.bodyText,
    this.body,
    this.topButtonText,
    this.topButtonAction,
    this.bottomButtonText,
    this.bottomButtonAction,
    this.removeBottomBodyPadding = false,
    this.showDialogButtons = true,
    this.barrierDismissible = true,
    this.centerBodyText = true,
    this.shouldTopActionPop = true,
    this.mainPadding,
    this.cancelButtonText,
    this.cancelButtonAction,
    this.buttonsPadding = EdgeInsets.zero,
    this.disableBack = false,
  });

  factory PhotoPulseDialog.discardChanges({
    required WidgetRef ref,
    required String title,
    String? bodyText,
    required VoidCallback onConfirmPressed,
    EdgeInsets buttonsPadding = EdgeInsets.zero,
    String? topButtonText,
  }) {
    return PhotoPulseDialog(
      title: title,
      bodyText: bodyText,
      topButtonAction: () => onConfirmPressed(),
      topButtonText: topButtonText ?? 'Yes, quit',
      bottomButtonText: 'Cancel',
      buttonsPadding: buttonsPadding,
    );
  }

  factory PhotoPulseDialog.confirm({
    required WidgetRef ref,
    required String title,
    String? bodyText,
    required String topButtonText,
    required VoidCallback onConfirmPressed,
    EdgeInsets buttonsPadding = EdgeInsets.zero,
    final String? cancelButtonText,
    final String? bottomButtonText,
  }) {
    return PhotoPulseDialog(
      title: title,
      bodyText: bodyText,
      topButtonAction: () {
        onConfirmPressed();
      },
      topButtonText: topButtonText,
      bottomButtonText: cancelButtonText != null ? null : 'Cancel',
      buttonsPadding: buttonsPadding,
      removeBottomBodyPadding: true,
      cancelButtonText: cancelButtonText,
    );
  }

  factory PhotoPulseDialog.postSuccessful(VoidCallback onConfirmPressed) {
    return PhotoPulseDialog(
      mainPadding: const EdgeInsets.all(AppSizes.bodyPaddingHorizontal),
      disableBack: true,
      title: 'Post successful',
      body: Column(
        children: [
          const SizedBox(height: AppSizes.smallSpacing),
          Icon(
            Icons.check_circle_rounded,
            color: AppColors.black,
            size: AppSizes.iconLargeSize,
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          const BodyText(
            'Your content was posted to the feed.',
            isCentered: true,
            isBold: true,
          ),
          const SizedBox(height: AppSizes.mediumSpacing),
          PhotoPulseTextButton(onTap: onConfirmPressed, label: 'Ok')
        ],
      ),
      removeBottomBodyPadding: true,
    );
  }

  Future<void> show(
    BuildContext context, {
    bool barrierDismissible = false,
  }) =>
      showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (context) => this,
      );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (disableBack ?? false) {
          return false;
        } else {
          return true;
        }
      },
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          padding: mainPadding ?? const EdgeInsets.all(AppSizes.largeSpacing),
          margin: const EdgeInsets.symmetric(
            horizontal: AppSizes.bodyPaddingHorizontal,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                topWidget ?? const SizedBox(),
                const SizedBox(height: AppSizes.normalSpacing),
                HeadlineText(
                  title,
                  isBold: true,
                  isCentered: true,
                  color: AppColors.black,
                ),
                if (bodyText != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.largeSpacing,
                    ),
                    child: SizedBox(
                      child: BodyText(
                        bodyText ?? '',
                        isCentered: centerBodyText,
                      ),
                    ),
                  ),
                if (body != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppSizes.normalSpacing,
                    ),
                    child: body,
                  ),
                if (!removeBottomBodyPadding)
                  const SizedBox(height: AppSizes.largeSpacing),
                if (showDialogButtons)
                  _Buttons(
                    topButtonAction: topButtonAction,
                    bottomButtonText: bottomButtonText,
                    bottomButtonAction: bottomButtonAction,
                    topButtonText: topButtonText,
                    shouldTopActionPop: shouldTopActionPop,
                    cancelButtonText: cancelButtonText,
                    cancelButtonAction: cancelButtonAction,
                    buttonsPadding: buttonsPadding,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  final String? topButtonText;
  final Function()? topButtonAction;
  final bool shouldTopActionPop;
  final String? bottomButtonText;
  final Function()? bottomButtonAction;
  final String? cancelButtonText;
  final Function()? cancelButtonAction;
  final EdgeInsets buttonsPadding;

  const _Buttons({
    super.key,
    required this.topButtonText,
    required this.topButtonAction,
    this.shouldTopActionPop = true,
    required this.bottomButtonText,
    required this.bottomButtonAction,
    required this.cancelButtonText,
    required this.cancelButtonAction,
    required this.buttonsPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: buttonsPadding,
      child: Column(
        children: [
          if (topButtonText != null)
            PhotoPulseButton.primary(
              onTap: () {
                topButtonAction?.call();
                if (shouldTopActionPop) Navigator.of(context).pop();
              },
              label: topButtonText ?? '',
            ),
          const SizedBox(
            height: AppSizes.normalSpacing,
          ),
          if (bottomButtonText != null)
            PhotoPulseButton.secondary(
              onTap: () {
                bottomButtonAction?.call();
                Navigator.of(context).pop();
              },
              label: bottomButtonText ?? '',
            ),
          if (cancelButtonText != null)
            TextButton(
              onPressed: () {
                cancelButtonAction?.call();
                Navigator.of(context).pop();
              },
              child: BodyText(
                cancelButtonText!,
                isBold: true,
              ),
            ),
        ],
      ),
    );
  }
}
