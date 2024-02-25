import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/presentation/dialogs/photo_pulse_dialog.dart';
import 'package:photopulse/generated/l10n.dart';

Future<dynamic> showUnsavedChangesDialog({
  VoidCallback? onConfirmPressed,
  required BuildContext context,
  required WidgetRef ref,
}) {
  return showDialog(
    context: context,
    builder: (context) => PhotoPulseDialog.confirm(
      ref: ref,
      title: S.current.unsaved_changes,
      bodyText: S.current.unsaved_changes_helper,
      topButtonText: S.current.quit,
      onConfirmPressed: onConfirmPressed ?? Navigator.of(context).pop,
    ),
  );
}
