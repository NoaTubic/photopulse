import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/photo_pulse_app_bar.dart';
import 'package:photopulse/common/presentation/photo_pulse_expansion_tile.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/common/presentation/photo_pulse_tile.dart';
import 'package:photopulse/features/subscription_management/presentation/widgets/current_subscription_section.dart';

class UploadContentPage extends StatelessWidget {
  static const routeName = Pages.uploadContent;
  const UploadContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PhotoPulseScaffold(
      appBar: PhotoPulseAppBar(
        title: 'Upload Content',
      ),
      body: Column(
        children: [
          PhotoPulseTile(
            label: 'Take photo',
            icon: Icons.camera_alt_rounded,
          ),
          Gap(AppSizes.normalSpacing),
          PhotoPulseTile(
            label: 'Load from gallery',
            icon: Icons.image_rounded,
          ),
          Gap(AppSizes.normalSpacing),
          PhotoPulseExpansionTile(
            title: 'Subscription Package',
            leadingIcon: Icons.edit_calendar_outlined,
            children: [
              CurrentSubscriptionSection(),
            ],
          ),
        ],
      ),
    );
  }
}
