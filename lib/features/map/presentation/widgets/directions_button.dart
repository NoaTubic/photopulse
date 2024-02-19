import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:latlong2/latlong.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/text/body_text.dart';
import 'package:photopulse/features/map/domain/utils/map_launcher.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:photopulse/theme/app_colors.dart';

class DirectionsButton extends StatelessWidget {
  final LatLng location;
  const DirectionsButton({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.normalSpacing),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: PhotoPulseButton.primary(
            onTap: () => MapLauncher(
              latLng: location,
            ).launch(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.directions_rounded,
                ),
                const Gap(AppSizes.normalSpacing),
                BodyText(
                  S.current.directions,
                  color: AppColors.white,
                  isBold: true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
