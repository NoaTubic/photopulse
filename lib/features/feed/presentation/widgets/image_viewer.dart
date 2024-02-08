import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/theme/app_colors.dart';

class ImageViewer extends ConsumerWidget {
  final Widget child;

  final String imageUrl;

  const ImageViewer({
    Key? key,
    required this.child,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UniqueKey heroTag = UniqueKey();
    return Hero(
      tag: heroTag,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              opaque: false,
              barrierColor: AppColors.black,
              pageBuilder: (BuildContext context, _, __) {
                return _FullScreenViewer(
                  tag: heroTag,
                  imageUrl: imageUrl,
                  child: child,
                );
              },
            ),
          );
        },
        child: child,
      ),
    );
  }
}

enum DisposeLevel { high, medium, low }

final scaleProvider = StateProvider<double>((ref) => 2.0);

class _FullScreenViewer extends HookConsumerWidget {
  final Widget child;
  final String imageUrl;

  final UniqueKey tag;

  const _FullScreenViewer({
    Key? key,
    required this.child,
    required this.tag,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = ref.watch(scaleProvider);

    return Hero(
      tag: tag,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Container(
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            children: [
              Center(
                child: ExtendedImage.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  mode: ExtendedImageMode.gesture,
                  initGestureConfigHandler: (state) {
                    return GestureConfig(
                      minScale: 0.9,
                      animationMinScale: 0.7,
                      maxScale: 3.0,
                      animationMaxScale: 3.5,
                      speed: 1.0,
                      inertialSpeed: 100.0,
                      initialScale: 1.0,
                      inPageView: false,
                      initialAlignment: InitialAlignment.center,
                    );
                  },
                  onDoubleTap: (state) {
                    state.handleDoubleTap(scale: scale);
                    scale == 1.0
                        ? ref.read(scaleProvider.notifier).state = 2.0
                        : ref.read(scaleProvider.notifier).state = 1.0;
                  },
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSizes.xLargeSpacing,
                    horizontal: AppSizes.bodyPaddingHorizontal,
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: SizedBox(
                      width: AppSizes.mediaButtonSize,
                      height: AppSizes.mediaButtonSize,
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
