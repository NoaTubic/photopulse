import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:photopulse/common/constants/duration_constants.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/image_assets.dart';
import 'package:photopulse/common/presentation/text/display_text.dart';
import 'package:photopulse/common/utils/build_context_extensions.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:photopulse/theme/app_colors.dart';
import 'package:photopulse/theme/theme.dart';

class AnimatedLogo extends HookWidget {
  const AnimatedLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final animationController =
        useAnimationController(duration: DurationConstants.logoAnimation);

    final zoomRotationAnimation = _scaleTween.animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    useEffect(() {
      animationController.forward();
      return null;
    }, const []);

    return Column(
      children: [
        Stack(
          children: [
            Center(
              child: FadeTransition(
                opacity: zoomRotationAnimation,
                child: Image.asset(
                  ImageAssets.pulse,
                  color: AppColors.black.withOpacity(0.2),
                  width: AppSizes.pulseLogoSize,
                  height: AppSizes.pulseLogoSize,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppSizes.mediumLargeSpacing),
              child: Center(
                child: AnimatedBuilder(
                  animation: zoomRotationAnimation,
                  builder: (context, child) {
                    final scale = _scaleFactor * zoomRotationAnimation.value;
                    final rotation =
                        _rotationFactor * zoomRotationAnimation.value;
                    return Transform.scale(
                      scale: scale,
                      child: Transform.rotate(
                        angle: rotation,
                        child: Image.asset(
                          ImageAssets.cameraLogo,
                          width: AppSizes.cameraLogoSize,
                          height: AppSizes.cameraLogoSize,
                          color: AppColors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        FadeTransition(
          opacity: zoomRotationAnimation,
          child: DisplayText(
            S.current.photo_pulse,
            color: AppColors.black,
            fontSize:
                context.isLargerThanMobile ? FontSizes.s30 : FontSizes.s24,
            fontFamily: Fonts.fontLogo,
          ),
        ),
      ],
    );
  }
}

const double _scaleFactor = 0.55 + 0.5;
const double _rotationFactor = 3 * 3.14;
final Tween<double> _scaleTween = Tween(begin: 0.0, end: 1.0);
