import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_text_button.dart';
import 'package:photopulse/common/presentation/text/body_text.dart';
import 'package:photopulse/theme/app_colors.dart';

class TextButtonRow extends StatelessWidget {
  final String text;
  final String buttonText;
  final void Function() onTap;

  const TextButtonRow({
    super.key,
    required this.text,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BodyText(text),
        PhotoPulseTextButton(
          onTap: onTap,
          label: buttonText,
          textColor: AppColors.black,
        ),
      ],
    );
  }
}
