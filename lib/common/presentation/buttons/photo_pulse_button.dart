import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/theme/app_colors.dart';
import 'package:photopulse/theme/app_text_styles.dart';
import 'package:photopulse/theme/theme.dart';

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
    Key? key,
    this.label,
    this.child,
    this.onTap,
    this.isEnabled = true,
    this.isLoading = false,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.width,
  }) : super(key: key);

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
      child: child,
    );
  }

  factory PhotoPulseButton.primaryLight({
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
      textColor: AppColors.primaryDefault,
      backgroundColor: AppColors.primaryLight,
      borderColor: AppColors.primaryLight,
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
      textColor: AppColors.primaryDefault,
      backgroundColor: AppColors.white,
      borderColor: AppColors.graysLight,
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
      textColor: AppColors.secondaryRed,
      backgroundColor: AppColors.secondaryRed.withOpacity(0.1),
      borderColor: Colors.transparent,
      child: child,
    );
  }

  factory PhotoPulseButton.socialLogin({
    String? icon,
    bool isLoading = false,
    required void Function()? onTap,
  }) {
    return PhotoPulseButton._(
      width: AppSizes.socialLoginButtonSize,
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
                : onTap
            : null,
        style: FilledButton.styleFrom(
          backgroundColor: isLoading
              ? backgroundColor
              : backgroundColor ?? AppColors.primaryDefault,
          textStyle: TextStyles.semiBold(
            color: textColor ?? AppColors.white,
            fontSize: FontSizes.s14,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: appBorderRadius,
          ),
          foregroundColor: textColor ?? AppColors.white,
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: 1,
            style: BorderStyle.solid,
          ),
          disabledBackgroundColor: AppColors.wireframeLight,
          disabledForegroundColor: AppColors.graysLight,
        ),
        child: isLoading
            ? SizedBox(
                height: AppSizes.mediaButtonSize,
                width: AppSizes.mediaButtonSize,
                child: CircularProgressIndicator(
                  color: AppColors.graysUltraLight,
                  backgroundColor: textColor,
                ),
              )
            : child ?? Text(label!),
      ),
    );
  }
}
