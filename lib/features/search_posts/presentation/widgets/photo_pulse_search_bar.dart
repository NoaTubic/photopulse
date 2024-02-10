import 'package:flutter/material.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/theme/app_colors.dart';

class PhotoPulseSearchBar extends StatelessWidget {
  const PhotoPulseSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return FloatingSearchBar(
      onQueryChanged: (query) {},
      onSubmitted: (query) {},
      builder: (context, transition) => const SizedBox(),
      body: Container(),
      accentColor: AppColors.black,
      iconColor: AppColors.black,
      backdropColor: AppColors.black.withOpacity(0.2),
      backgroundColor: AppColors.white,
      // width: 0.8 * screenWidth,
      // openWidth: screenWidth,
      // axisAlignment: -1,
      elevation: 0,
      borderRadius: BorderRadius.circular(AppSizes.normalCircularRadius),
      border: BorderSide(color: AppColors.black),
    );
  }
}
