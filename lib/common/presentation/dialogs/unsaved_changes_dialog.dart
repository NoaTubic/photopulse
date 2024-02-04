import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/presentation/dialogs/photo_pulse_dialog.dart';

Future<dynamic> showUnsavedChangesDialog({
  VoidCallback? onConfirmPressed,
  required BuildContext context,
  required WidgetRef ref,
}) {
  return showDialog(
    context: context,
    builder: (context) => PhotoPulseDialog.confirm(
      ref: ref,
      title: 'Are you sure you want to quit?',
      bodyText: 'If you quit now, the changes you made will be lost.',
      topButtonText: 'Yes, quit',
      onConfirmPressed: onConfirmPressed ?? Navigator.of(context).pop,
    ),
  );
}
