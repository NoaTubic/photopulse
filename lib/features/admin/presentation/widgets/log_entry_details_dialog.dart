import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/body_text.dart';
import 'package:photopulse/features/admin/domain/entities/log_entry.dart';
import 'package:photopulse/features/auth/domain/entities/user.dart';
import 'package:photopulse/features/post/domain/entities/post.dart';
import 'package:photopulse/theme/app_colors.dart';

void showLogEntryDialog(BuildContext context, LogEntry logEntry) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        title: const BodyText(
          'Log Entry Details',
          isBold: true,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyText('Event Type: ${logEntry.eventType.toUpperCase()}'),
              const Gap(AppSizes.tinySpacing),
              BodyText('Collection: ${logEntry.collection}'),
              const Gap(AppSizes.tinySpacing),
              BodyText('Document ID: ${logEntry.documentId}'),
              const Gap(AppSizes.tinySpacing),
              BodyText(
                  'Timestamp: ${DateFormat('dd/MM/yyyy HH:mm').format(logEntry.timestamp.toDate())}'),
              _buildExpandableDataView(
                  'Before Data', logEntry.beforeData, context),
              const Gap(AppSizes.tinySpacing),
              _buildExpandableDataView(
                  'After Data', logEntry.afterData, context),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const BodyText('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Widget _buildExpandableDataView(
    String title, Object? data, BuildContext context) {
  return Theme(
    data: Theme.of(context).copyWith(
      dividerColor: Colors.transparent,
    ),
    child: ExpansionTile(
      title: BodyText(
        title,
        isBold: true,
      ),
      children: [
        if (data != null)
          Padding(
            padding: const EdgeInsets.all(AppSizes.smallSpacing),
            child: BodyText(data is PhotoPulseUser
                ? (data).toString()
                : (data as Post).toString()),
          )
        else
          const Padding(
            padding: EdgeInsets.all(AppSizes.smallSpacing),
            child: BodyText('No data available'),
          ),
      ],
    ),
  );
}
