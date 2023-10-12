// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

extension BuildContextExtensions on BuildContext {
  AppTextStyles get appTextStyles => Theme.of(this).extension<AppTextStyles>()!;
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
