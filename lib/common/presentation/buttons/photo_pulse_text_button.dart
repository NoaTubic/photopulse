import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/text/text.dart';

class PhotoPulseTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color? textColor;
  const PhotoPulseTextButton({
    super.key,
    required this.onTap,
    required this.label,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: BodyText(
        label,
        isBold: true,
        color: textColor,
      ),
    );
  }
}
