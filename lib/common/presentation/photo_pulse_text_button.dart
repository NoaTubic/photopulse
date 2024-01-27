import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/text/text.dart';

class PhotoPulseTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  const PhotoPulseTextButton({
    super.key,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: BodyText(
        label,
      ),
    );
  }
}
