import 'package:flutter/material.dart';
import 'package:photopulse/common/constants/duration_constants.dart';

class MediaContainer extends StatelessWidget {
  final bool isVisible;
  final Alignment alignment;
  final EdgeInsets fullScreenPadding;
  final EdgeInsets padding;
  final Widget child;

  const MediaContainer({
    super.key,
    this.isVisible = true,
    this.alignment = Alignment.center,
    this.fullScreenPadding = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1 : 0,
      duration: DurationConstants.visibilityAnimationDuration,
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: MediaQuery.of(context).orientation == Orientation.landscape
              ? fullScreenPadding
              : padding,
          child: child,
        ),
      ),
    );
  }
}
