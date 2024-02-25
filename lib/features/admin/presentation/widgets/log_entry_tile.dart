import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photopulse/common/constants/constants.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/body_text.dart';
import 'package:photopulse/features/admin/domain/entities/log_entry.dart';
import 'package:photopulse/features/admin/presentation/widgets/log_entry_details_dialog.dart';

class LogEntryTile extends StatelessWidget {
  final LogEntry logEntry;

  const LogEntryTile({super.key, required this.logEntry});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.bodyPaddingHorizontal),
      title: BodyText(
        logEntry.eventType.toUpperCase(),
        isBold: true,
      ),
      subtitle: Text('${logEntry.collection} - ${logEntry.documentId}'),
      trailing: Text(
          DateFormat(Constants.dateFormat).format(logEntry.timestamp.toDate())),
      onTap: () => showLogEntryDialog(context, logEntry),
    );
  }
}
