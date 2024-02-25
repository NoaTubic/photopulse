import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:photopulse/common/constants/constants.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/body_text.dart';
import 'package:photopulse/features/admin/domain/entities/log_entry.dart';
import 'package:photopulse/features/auth/domain/entities/user.dart';
import 'package:photopulse/features/post/domain/entities/post.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:photopulse/theme/app_colors.dart';

void showLogEntryDialog(BuildContext context, LogEntry logEntry) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        title: BodyText(
          S.current.log_entry_details,
          isBold: true,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyText(
                  '${S.current.event_type}: ${logEntry.eventType.toUpperCase()}'),
              const Gap(AppSizes.tinySpacing),
              BodyText('${S.current.collection}: ${logEntry.collection}'),
              const Gap(AppSizes.tinySpacing),
              BodyText('${S.current.document_id}: ${logEntry.documentId}'),
              const Gap(AppSizes.tinySpacing),
              BodyText(
                  '${S.current.timestamp}: ${DateFormat(Constants.dateFormat).format(logEntry.timestamp.toDate())}'),
              _buildExpandableDataView(
                  S.current.before_data, logEntry.beforeData, context),
              const Gap(AppSizes.tinySpacing),
              _buildExpandableDataView(
                  S.current.after_data, logEntry.afterData, context),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: BodyText(S.current.close),
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
          Padding(
            padding: const EdgeInsets.all(AppSizes.smallSpacing),
            child: BodyText(S.current.no_data_available),
          ),
      ],
    ),
  );
}
