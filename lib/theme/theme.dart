// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

part 'fonts.dart';

final _theme = ThemeData();
final lightTheme = ThemeData(
  splashColor: AppColors.graysUltraLight,
  highlightColor: AppColors.graysUltraLight,
  useMaterial3: true,
  fontFamily: 'Cocogoose Pro',

  primarySwatch: Colors.cyan,
  colorScheme: _theme.colorScheme.copyWith(secondary: Colors.cyan),
  scaffoldBackgroundColor: Colors.white,
  // ignore: deprecated_member_use
  backgroundColor: Colors.grey,
  appBarTheme: AppBarTheme(
    scrolledUnderElevation: 0,
    titleTextStyle: TextStyles.medium(
      fontSize: FontSizes.s18,
      color: AppColors.black,
    ),
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: AppColors.white,
    surfaceTintColor: AppColors.white,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
  ),
  popupMenuTheme: PopupMenuThemeData(
    surfaceTintColor: AppColors.white,
    shape: const OutlineInputBorder(
      borderRadius: appBorderRadius,
      borderSide: BorderSide.none,
    ),
  ),
  textTheme: TextTheme(
    displayMedium: TextStyles.semiBold(
      color: AppColors.greyDark30,
      fontSize: FontSizes.s24,
    ),
    headlineMedium: TextStyles.semiBold(
      color: AppColors.greyDark30,
      fontSize: FontSizes.s18,
    ),
    titleMedium: TextStyles.semiBold(
      color: AppColors.greyDark30,
      fontSize: FontSizes.s16,
    ),
    bodyMedium: TextStyles.regular(
      color: AppColors.greyDark30,
      fontSize: FontSizes.s14,
    ),
    labelMedium: TextStyles.medium(
      color: AppColors.greyDark30,
      fontSize: FontSizes.s12,
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColors.primaryDefault,
      textStyle: TextStyles.semiBold(
        color: Colors.white,
        fontSize: FontSizes.s14,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: appBorderRadius,
      ),
      minimumSize: const Size.fromHeight(AppSizes.filledButtonHeight),
      disabledBackgroundColor: AppColors.wireframeLight,
      disabledForegroundColor: AppColors.greyDark,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(AppSizes.tinySpacing),
      textStyle: TextStyles.medium(
        color: AppColors.wireFrameMedium,
        fontSize: FontSizes.s14,
      ),
      backgroundColor: Colors.white,
      foregroundColor: AppColors.wireFrameMedium,
    ),
  ),
  inputDecorationTheme: inputDecorationTheme,
  dialogTheme: const DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.all(Radius.circular(AppSizes.mediumCircularRadius)),
    ),
    backgroundColor: Colors.white,
  ),
  progressIndicatorTheme:
      ProgressIndicatorThemeData(color: AppColors.primaryDefault),

  listTileTheme: ListTileThemeData(
    shape: const RoundedRectangleBorder(
      borderRadius: appBorderRadius,
    ),
    tileColor: AppColors.white,
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStatePropertyAll(AppColors.white),
    trackColor: MaterialStatePropertyAll(AppColors.graysLight),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: AppColors.primaryLight,
  ),
);

const appBorderRadius =
    BorderRadius.all(Radius.circular(AppSizes.normalCircularRadius));

final inputDecorationTheme = InputDecorationTheme(
  constraints: const BoxConstraints(maxWidth: 300),
  floatingLabelBehavior: FloatingLabelBehavior.always,
  isDense: true,
  filled: true,
  fillColor: AppColors.graysInput,
  hintStyle: _theme.textTheme.bodyMedium!.copyWith(
    color: AppColors.wireFrameMedium2,
  ),
  errorStyle: _theme.textTheme.bodyMedium!
      .copyWith(color: AppColors.alertCritical, fontSize: FontSizes.s12),
  labelStyle:
      _theme.textTheme.bodyMedium!.copyWith(color: AppColors.wireFrameDark),
  floatingLabelStyle:
      _theme.textTheme.bodyMedium!.copyWith(color: AppColors.wireFrameDark),
  border: OutlineInputBorder(
    borderRadius: appBorderRadius,
    borderSide: BorderSide(color: AppColors.wireFrameMedium2),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: appBorderRadius,
    borderSide: BorderSide(color: AppColors.wireFrameMedium2),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: appBorderRadius,
    borderSide: BorderSide(color: AppColors.wireFrameDark),
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
    borderSide: BorderSide(color: AppColors.wireFrameMedium2),
  ),
  contentPadding: const EdgeInsets.all(AppSizes.normalSpacing),
);
