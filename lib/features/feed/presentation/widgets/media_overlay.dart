import 'package:flutter/material.dart';
import 'package:photopulse/theme/app_colors.dart';

class MediaOverlay extends StatelessWidget {
  final Widget? child;
  final double opacity;
  const MediaOverlay({super.key, this.child, this.opacity = 0.2});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black.withOpacity(opacity),
      child: Center(child: child),
    );
  }
}
