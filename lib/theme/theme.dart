// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

part 'fonts.dart';

final lightTheme = ThemeData(
  splashColor: AppColors.black.withOpacity(0.1),
  highlightColor: AppColors.black.withOpacity(0.1),
  fontFamily: Fonts.fontFamily,
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.white,
  inputDecorationTheme: inputDecorationTheme,
  textTheme: TextTheme(
    displayMedium: TextStyles.semiBold(
      color: AppColors.black,
      fontSize: FontSizes.s24,
    ),
    headlineMedium: TextStyles.semiBold(
      color: AppColors.black,
      fontSize: FontSizes.s18,
    ),
    titleMedium: TextStyles.semiBold(
      color: AppColors.black,
      fontSize: FontSizes.s16,
    ),
    bodyMedium: TextStyles.regular(
      color: AppColors.black,
      fontSize: FontSizes.s14,
    ),
    labelMedium: TextStyles.medium(
      color: AppColors.black,
      fontSize: FontSizes.s12,
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      maximumSize: const Size(AppSizes.maxWidth, AppSizes.filledButtonHeight),
      backgroundColor: AppColors.black,
      textStyle: TextStyles.semiBold(
        color: Colors.white,
        fontSize: FontSizes.s14,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: appBorderRadiusHigh,
      ),
      minimumSize: const Size(AppSizes.maxWidth, AppSizes.filledButtonHeight),
      disabledBackgroundColor: AppColors.black,
      disabledForegroundColor: AppColors.white,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(AppSizes.tinySpacing),
      textStyle: TextStyles.medium(
        color: AppColors.black,
        fontSize: FontSizes.s14,
      ),
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.black,
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.black,
    selectionColor: AppColors.black.withOpacity(0.1),
    selectionHandleColor: AppColors.black,
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.black,
    refreshBackgroundColor: AppColors.black.withOpacity(0.2),
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: AppColors.white,
    surfaceTintColor: AppColors.white,
    iconColor: AppColors.black,
    shape: const RoundedRectangleBorder(
      borderRadius: appBorderRadius,
    ),
  ),
);

const appBorderRadius =
    BorderRadius.all(Radius.circular(AppSizes.normalCircularRadius));

const appBorderRadiusHigh =
    BorderRadius.all(Radius.circular(AppSizes.highCircularRadius));

final inputDecorationTheme = InputDecorationTheme(
  constraints: const BoxConstraints(maxWidth: AppSizes.maxWidth),
  floatingLabelBehavior: FloatingLabelBehavior.always,
  isDense: true,
  filled: true,
  fillColor: AppColors.white,
  hintStyle: TextStyles.regular(
    color: AppColors.black,
    fontSize: FontSizes.s14,
  ),
  errorStyle: TextStyles.regular(
    color: AppColors.alertCritical,
    fontSize: FontSizes.s14,
  ),
  labelStyle: TextStyles.regular(
    color: AppColors.black,
    fontSize: FontSizes.s14,
  ),
  floatingLabelStyle: TextStyles.regular(
    color: AppColors.black,
    fontSize: FontSizes.s14,
  ),
  border: OutlineInputBorder(
    borderRadius: appBorderRadius,
    borderSide: BorderSide(color: AppColors.black),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: appBorderRadius,
    borderSide: BorderSide(color: AppColors.black),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: appBorderRadius,
    borderSide: BorderSide(color: AppColors.black),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: appBorderRadius,
    borderSide: BorderSide(color: AppColors.alertCritical),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: appBorderRadius,
    borderSide: BorderSide(color: AppColors.alertCritical),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: appBorderRadius,
    borderSide: BorderSide(color: AppColors.black),
  ),
  contentPadding: const EdgeInsets.all(AppSizes.normalSpacing),
);
