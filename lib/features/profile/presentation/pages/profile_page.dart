import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/photo_pulse_expansion_tile.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:photopulse/features/subscription_management/presentation/widgets/current_subscription_section.dart';

class ProfilePage extends ConsumerWidget {
  static const routeName = Pages.profile;

  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PhotoPulseScaffold(
      body: Column(
        children: [
          const PhotoPulseExpansionTile(
            title: 'Subscription Package',
            leadingIcon: Icons.edit_calendar_outlined,
            children: [
              CurrentSubscriptionSection(),
            ],
          ),
          const Spacer(),
          PhotoPulseButton.primary(
            onTap: () => ref.read(authNotifierProvider.notifier).logout(),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
