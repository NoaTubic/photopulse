import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/camera/domain/notifiers/camera_notifier.dart';
import 'package:photopulse/features/camera/domain/notifiers/camera_state.dart';

class CameraAspectRatio extends ConsumerWidget {
  final Widget child;
  const CameraAspectRatio({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log(MediaQuery.of(context).size.height.toString());
    return ClipRect(
      clipper: MediaSizeClipper(MediaQuery.of(context).size),
      child: Transform.scale(
        scale: _aspectRatio(ref.read(cameraNotifierProvider), context),
        child: child,
      ),
    );
  }
}

double _aspectRatio(CameraState state, BuildContext context) {
  return 1 /
      (MediaQuery.of(context).size.height > 700
          ? (state.controller!.value.aspectRatio *
              MediaQuery.of(context).size.aspectRatio)
          : MediaQuery.of(context).size.aspectRatio);
}

class MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;
  const MediaSizeClipper(this.mediaSize);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(
      0,
      0,
      mediaSize.width,
      mediaSize.height,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
