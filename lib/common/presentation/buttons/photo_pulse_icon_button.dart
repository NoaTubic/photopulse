import 'package:flutter/material.dart';

class PhotoPulseIconButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? iconColor;
  final Color borderColor;
  final double width;
  final double height;
  const PhotoPulseIconButton({
    Key? key,
    required this.icon,
    this.onTap,
    this.backgroundColor = Colors.white,
    this.foregroundColor = Colors.white,
    this.iconColor,
    this.borderColor = Colors.transparent,
    this.width = 48,
    this.height = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        minimumSize: Size(width, height),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        side: BorderSide(
          color: borderColor,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}
