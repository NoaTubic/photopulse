import 'package:flutter/material.dart';

import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/theme/app_colors.dart';
import 'package:photopulse/theme/app_text_styles.dart';
import 'package:photopulse/theme/theme.dart';

//DESIGN PATTERN: FACTORY
class PhotoPulseButton extends StatelessWidget {
  final String? label;
  final Widget? child;
  final void Function()? onTap;
  final bool isEnabled;
  final bool isLoading;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? width;

  const PhotoPulseButton._({
    this.label,
    this.child,
    this.onTap,
    this.isEnabled = true,
    this.isLoading = false,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.width,
  });

  factory PhotoPulseButton.primary({
    String? label,
    Widget? child,
    bool isLoading = false,
    required void Function()? onTap,
    final bool? isEnabled,
  }) {
    return PhotoPulseButton._(
      label: label,
      onTap: onTap,
      isEnabled: isEnabled ?? true,
      isLoading: isLoading,
      borderColor: AppColors.black,
      backgroundColor: AppColors.black,
      child: child,
    );
  }

  factory PhotoPulseButton.white({
    String? label,
    Widget? child,
    bool isLoading = false,
    required void Function()? onTap,
    final bool? isEnabled,
  }) {
    return PhotoPulseButton._(
      label: label,
      onTap: onTap,
      isEnabled: isEnabled ?? true,
      isLoading: isLoading,
      textColor: AppColors.white,
      backgroundColor: AppColors.accentDark,
      borderColor: AppColors.black,
      child: child,
    );
  }

  factory PhotoPulseButton.secondary({
    String? label,
    Widget? child,
    bool isLoading = false,
    required void Function()? onTap,
    final bool? isEnabled,
  }) {
    return PhotoPulseButton._(
      label: label,
      onTap: onTap,
      isEnabled: isEnabled ?? true,
      isLoading: isLoading,
      textColor: AppColors.black,
      backgroundColor: AppColors.white,
      borderColor: AppColors.black,
      child: child,
    );
  }
  factory PhotoPulseButton.tertiary({
    String? label,
    Widget? child,
    bool isLoading = false,
    required void Function()? onTap,
    final bool? isEnabled,
  }) {
    return PhotoPulseButton._(
      label: label,
      onTap: onTap,
      isEnabled: isEnabled ?? true,
      isLoading: isLoading,
      textColor: AppColors.white,
      backgroundColor: AppColors.white.withOpacity(0.1),
      borderColor: Colors.transparent,
      child: child,
    );
  }

  factory PhotoPulseButton.socialLogin({
    String? icon,
    required void Function()? onTap,
  }) {
    return PhotoPulseButton._(
      onTap: onTap,
      isEnabled: true,
      isLoading: false,
      width: AppSizes.socialLoginButtonSize,
      backgroundColor: AppColors.white,
      borderColor: AppColors.black,
      label: '',
      textColor: AppColors.white,
      child: Image.asset(
        icon ?? '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: FilledButton(
        onPressed: isEnabled
            ? isLoading
                ? () {}
                : () {
                    if (FocusScope.of(context).hasFocus) {
                      FocusScope.of(context).unfocus();
                    }
                    onTap!();
                  }
            : null,
        style: FilledButton.styleFrom(
          backgroundColor:
              isLoading ? backgroundColor : backgroundColor ?? AppColors.black,
          textStyle: TextStyles.semiBold(
            color: textColor ?? AppColors.white,
            fontSize: FontSizes.s14,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: appBorderRadiusHigh,
          ),
          foregroundColor: textColor ?? AppColors.white,
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        child: isLoading
            ? Container(
                padding: const EdgeInsets.all(AppSizes.tinySpacing),
                height: AppSizes.mediaButtonSize,
                width: AppSizes.mediaButtonSize,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  backgroundColor: textColor,
                ),
              )
            : child ?? Text(label!),
      ),
    );
  }
}
