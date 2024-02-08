import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/presentation/animated_widgets/animated_column.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/dialogs/permission_dialog.dart';
import 'package:photopulse/common/presentation/photo_pulse_app_bar.dart';
import 'package:photopulse/common/presentation/photo_pulse_expansion_tile.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/common/presentation/photo_pulse_tile.dart';
import 'package:photopulse/common/presentation/photo_pulse_toast.dart';
import 'package:photopulse/features/camera/presentation/pages/photo_pulse_camera.dart';
import 'package:photopulse/features/camera/presentation/pages/review_photo_page.dart';
import 'package:photopulse/features/gallery/domain/notifier/gallery_notifier.dart';
import 'package:photopulse/features/gallery/domain/notifier/gallery_state.dart';
import 'package:photopulse/features/navbar/domain/notifiers/nav_bar_visibility_provider.dart';
import 'package:photopulse/features/subscription_management/presentation/widgets/current_subscription_section.dart';
import 'package:photopulse/theme/app_colors.dart';
import 'package:q_architecture/q_architecture.dart';

class UploadContentPage extends ConsumerWidget {
  static const routeName = Pages.uploadContent;
  const UploadContentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<GalleryState>(
      galleryNotifierProvider,
      (previous, next) {
        if (next.failure != null &&
            next.failure != Failure.permissionDenied()) {
          PhotoPulseToast(
            message: next.failure!.title,
          ).show(context);
        }
        if (next.content != null) {
          ref.read(navBarVisibilityProvider.notifier).toggleNavBarVisibility();
          ref.pushNamed(
            '${UploadContentPage.routeName}${ReviewPhotoPage.routeName}',
            data: true,
          );
        }
      },
    );

    return PhotoPulseScaffold(
      appBar: const PhotoPulseAppBar(
        title: 'Upload Content',
      ),
      body: AnimatedColumn(
        children: [
          PhotoPulseTile(
            label: 'Take photo',
            icon: Icons.camera_alt_rounded,
            onTap: () {
              ref
                  .read(navBarVisibilityProvider.notifier)
                  .toggleNavBarVisibility();
              ref.pushNamed(
                '${UploadContentPage.routeName}${PhotoPulseCamera.routeName}',
              );
            },
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          PhotoPulseTile(
            label: 'Load from gallery',
            icon: Icons.image_rounded,
            onTap: () => _onGalleryButtonTapped(
              ref.watch(galleryNotifierProvider),
              ref.read(galleryNotifierProvider.notifier),
              context,
            ),
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          const PhotoPulseExpansionTile(
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

void _onGalleryButtonTapped(
  GalleryState state,
  GalleryNotifier galleryNotifier,
  BuildContext context,
) {
  if (state.failure == Failure.permissionDenied()) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const PermissionsDialog(
        errorText:
            'For uploading photos, please allow the PhotoPulse app access to your gallery.',
        helperText:
            'Go to you settings > Permissions and turn on the photos and storage',
        icon: Icons.camera_alt_rounded,
      ),
    );
  }
  galleryNotifier.loadFromGallery();
}
