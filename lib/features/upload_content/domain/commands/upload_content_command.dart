import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/commands/command.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/presentation/dialogs/permission_dialog.dart';
import 'package:photopulse/features/camera/presentation/pages/photo_pulse_camera.dart';
import 'package:photopulse/features/gallery/domain/notifier/gallery_notifier.dart';
import 'package:photopulse/features/navbar/domain/notifiers/nav_bar_visibility_provider.dart';
import 'package:photopulse/features/upload_content/presentation/pages/upload_content_page.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:q_architecture/q_architecture.dart';

class UploadContentCommand implements Command {
  final WidgetRef ref;
  final BuildContext context;
  final bool isGallery;

  UploadContentCommand(
      {required this.ref, required this.context, required this.isGallery});

  @override
  void execute() {
    ();
    isGallery
        ? {
            if (ref.watch(galleryNotifierProvider).failure ==
                Failure.permissionDenied())
              {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => PermissionsDialog(
                    errorText: S.current.gallery_permissions_dialog_error,
                    helperText: S.current.gallery_permissions_dialog_helper,
                    icon: Icons.camera_alt_rounded,
                  ),
                ),
              },
            ref.read(galleryNotifierProvider.notifier).loadFromGallery(),
          }
        : {
            ref
                .read(navBarVisibilityProvider.notifier)
                .toggleNavBarVisibility(),
            ref.pushNamed(
              '${UploadContentPage.routeName}${PhotoPulseCamera.routeName}',
            ),
          };
  }
}
