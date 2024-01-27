import 'package:flutter/material.dart';

abstract class AppSizes {
  static const double tinySpacing = 4;
  static const double smallSpacing = 8;
  static const double compactSpacing = 12;
  static const double normalSpacing = 16;
  static const double mediumSpacing = 24;
  static const double largeSpacing = 32;
  static const double xLargeSpacing = 48;
  static const double bodyPaddingHorizontal = 20;
  static const double bodyPaddingVertical = 16;
  static const double normalCircularRadius = 10;
  static const double highCircularRadius = 40;
  static const double filledButtonHeight = 44;
  static const double appLogo = 120;
  static const double appLogoWeb = 200;
  static const double logoSmall = 24;
  static const double mediumCircularRadius = 24;
  static const double commentBoxMaxHeight = 150;
  static const double mediaButtonSize = 32;
  static const double animatedButtonSize = 54;
  static const double mediaProgressBarTapArea = 16;
  static const double imageViewerHeightMin = 200;
  static const double imageViewerHeightMax = 400;
  static const double videoPlayerHeight = 260;
  static const double audioPlayerHeight = 132;
  static const double smallAvatarRadius = 32;
  static const double mediumAvatarRadius = 42;
  static const double largeAvatarRadius = 128;
  static const double xLargeAvatarRadius = 160;
  static const double chatBubbleCircularRadius = 16;
  static const double maxWidth = 360;
  static const double socialLoginButtonSize = 72;

  static const double navigationRailWidth = 330;

  static const double navigationRailBreakingPoint = 640;

  static const BorderRadiusGeometry normalCircularBorderRadius =
      BorderRadius.all(
    Radius.circular(normalCircularRadius),
  );
}
