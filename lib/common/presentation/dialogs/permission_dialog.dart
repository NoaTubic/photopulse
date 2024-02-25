import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/dialogs/photo_pulse_dialog.dart';
import 'package:photopulse/common/presentation/text/body_text.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:photopulse/theme/app_colors.dart';

class PermissionsDialog extends ConsumerWidget {
  final String errorText;
  final String? helperText;
  final IconData icon;
  final VoidCallback? onPop;

  const PermissionsDialog({
    super.key,
    required this.errorText,
    this.helperText,
    required this.icon,
    this.onPop,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PhotoPulseDialog(
      topWidget: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.largeSpacing,
              vertical: AppSizes.largeSpacing,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(
                  AppSizes.normalCircularRadius,
                ),
                topRight: Radius.circular(
                  AppSizes.normalCircularRadius,
                ),
              ),
            ),
            width: double.infinity,
            height: AppSizes.permissionDialogHeight,
            child: Icon(
              icon,
              // ignore: deprecated_member_use
              color: AppColors.white,
            ),
          ),
        ],
      ),
      title: '',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.largeSpacing),
        child: Column(
          children: [
            BodyText(
              errorText,
              isCentered: true,
            ),
            const SizedBox(
              height: AppSizes.mediumSpacing,
            ),
            BodyText(
              helperText ?? '',
              isCentered: true,
            ),
          ],
        ),
      ),
      mainPadding: const EdgeInsets.only(bottom: AppSizes.largeSpacing),
      buttonsPadding:
          const EdgeInsets.symmetric(horizontal: AppSizes.largeSpacing),
      topButtonText: S.current.i_understand,
      bottomButtonText: S.current.device_settings,
      bottomButtonAction: openAppSettings,
      topButtonAction: () => null,
    );
  }
}
