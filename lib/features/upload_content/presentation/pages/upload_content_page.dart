import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/constants/duration_constants.dart';
import 'package:photopulse/common/domain/commands/command_executor.dart';
import 'package:photopulse/common/domain/commands/show_toast_command.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/presentation/animated_widgets/animated_column.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/photo_pulse_app_bar.dart';
import 'package:photopulse/common/presentation/photo_pulse_expansion_tile.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/common/presentation/photo_pulse_tile.dart';
import 'package:photopulse/common/presentation/photo_pulse_toast.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/features/auth/domain/notifiers/user_notifier.dart';
import 'package:photopulse/features/camera/presentation/pages/review_photo_page.dart';
import 'package:photopulse/features/gallery/domain/notifier/gallery_notifier.dart';
import 'package:photopulse/features/gallery/domain/notifier/gallery_state.dart';
import 'package:photopulse/features/navbar/domain/notifiers/nav_bar_visibility_provider.dart';
import 'package:photopulse/features/subscription_management/presentation/widgets/current_subscription_section.dart';
import 'package:photopulse/features/upload_content/domain/commands/upload_content_command.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:q_architecture/q_architecture.dart';

class UploadContentPage extends ConsumerWidget {
  static const routeName = Pages.uploadContent;
  const UploadContentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAnonymousUser = ref.watch(isAnonymousProvider);
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
      appBar: PhotoPulseAppBar(
        title: S.current.upload_content,
      ),
      body: AnimatedColumn(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  PhotoPulseTile(
                    label: S.current.take_photo,
                    icon: Icons.camera_alt_rounded,
                    onTap: () => CommandExecutor(
                      condition:
                          ref.read(userProvider.notifier).isUploadLimitReached,
                      trueCommand: UploadContentCommand(
                          ref: ref, context: context, isGallery: false),
                      falseCommand: ShowToastCommand(
                          context, S.current.upload_limit_reached),
                    ).execute(),
                  ),
                  const SizedBox(height: AppSizes.normalSpacing),
                  PhotoPulseTile(
                    label: S.current.load_from_gallery,
                    icon: Icons.image_rounded,
                    onTap: () => CommandExecutor(
                      condition:
                          ref.read(userProvider.notifier).isUploadLimitReached,
                      trueCommand: UploadContentCommand(
                          ref: ref, context: context, isGallery: true),
                      falseCommand: ShowToastCommand(
                          context, S.current.upload_limit_reached),
                    ).execute(),
                  ),
                  const SizedBox(height: AppSizes.normalSpacing),
                  PhotoPulseExpansionTile(
                    title: S.current.subscription_package,
                    leadingIcon: Icons.edit_calendar_outlined,
                    children: const [
                      CurrentSubscriptionSection(),
                    ],
                  ),
                ],
              ),
              if (isAnonymousUser)
                Positioned.fill(
                  child: AnimatedOpacity(
                    duration: DurationConstants.mediumAnimationDuration,
                    opacity: isAnonymousUser ? 1 : 0,
                    child: Container(
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                )
            ],
          ),
          if (isAnonymousUser) ...[
            const SizedBox(height: AppSizes.largeSpacing),
            const Center(
              child: HeadlineText(
                'Please login or register to upload content.',
                isBold: true,
                isCentered: true,
              ),
            )
          ]
        ],
      ),
    );
  }
}
