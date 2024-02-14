import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 2500),
    );

    final zoomRotationAnimation = Tween(begin: 0.0, end: 1.0).animate(
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
                  width: 180,
                  height: 180,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28),
              child: Center(
                child: AnimatedBuilder(
                  animation: zoomRotationAnimation,
                  builder: (context, child) {
                    final scale = 0.55 + 0.5 * zoomRotationAnimation.value;
                    final rotation = 3 * 3.14 * zoomRotationAnimation.value;
                    return Transform.scale(
                      scale: scale,
                      child: Transform.rotate(
                        angle: rotation,
                        child: Image.asset(
                          ImageAssets.cameraLogo,
                          width: 120,
                          height: 120,
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
