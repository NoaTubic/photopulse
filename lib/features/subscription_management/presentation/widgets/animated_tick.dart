import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:photopulse/common/constants/duration_constants.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/theme/app_colors.dart';

class AnimatedTick extends HookWidget {
  final bool isChecked;
  final Duration duration;

  const AnimatedTick({
    super.key,
    this.isChecked = false,
    this.duration = DurationConstants.logoAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: duration);
    final animation =
        useAnimation(Tween<double>(begin: 0.0, end: 1.0).animate(controller));

    useEffect(
      () {
        isChecked ? controller.forward() : controller.reverse();
        return null;
      },
      [isChecked],
    );

    return Opacity(
      opacity: animation,
      child: Icon(
        Icons.done_outline_rounded,
        size: AppSizes.iconLargeSize,
        color: AppColors.black,
      ),
    );
  }
}
