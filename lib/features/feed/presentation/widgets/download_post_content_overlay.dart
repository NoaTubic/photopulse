import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/dialogs/permission_dialog.dart';
import 'package:photopulse/common/presentation/text/body_text.dart';
import 'package:photopulse/features/feed/presentation/widgets/media_container.dart';
import 'package:photopulse/features/feed/presentation/widgets/media_overlay.dart';
import 'package:photopulse/features/post/domain/notifiers/download_post_content_notifier.dart';
import 'package:photopulse/theme/app_colors.dart';
import 'package:q_architecture/base_state_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

class DownloadPostContentOverlay extends ConsumerStatefulWidget {
  final String id;
  final Widget child;
  const DownloadPostContentOverlay({
    super.key,
    required this.id,
    required this.child,
  });

  @override
  ConsumerState<DownloadPostContentOverlay> createState() =>
      _DownloadPostContentOverlayState();
}

class _DownloadPostContentOverlayState
    extends ConsumerState<DownloadPostContentOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // ignore: unused_field
  late Animation<double> _animation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut,
      ),
    );

    _controller.addListener(() {
      if (_controller.isAnimating != _isVisible) {
        setState(() {
          _isVisible = _controller.isAnimating;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BaseState<void>>(downloadPostContentNotifierProvider(widget.id),
        (_, next) async {
      return switch (next) {
        BaseData() => _startAnimation(),
        BaseError(failure: final _) => showDialog(
            context: context,
            builder: (context) => const PermissionsDialog(
              errorText:
                  'For downloading photos, please allow the PhotoPulse app access to your storage.',
              helperText:
                  'Go to you settings > Permissions and turn on the photos and storage',
              icon: Icons.download_rounded,
            ),
          ),
        _ => null,
      };
    });
    return Stack(
      children: [
        widget.child,
        if (_isVisible)
          Positioned.fill(
            child: MediaContainer(
              isVisible: _isVisible,
              child: MediaOverlay(
                opacity: 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline_rounded,
                      color: AppColors.white,
                      size: 60,
                    ),
                    const SizedBox(
                      height: AppSizes.smallSpacing,
                    ),
                    BodyText(
                      'Successfully saved!',
                      color: AppColors.white,
                      isBold: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _startAnimation() async {
    _controller.forward();
    await Future.delayed(const Duration(seconds: 1), () {});
    _controller.reverse();
  }
}
