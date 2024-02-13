import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/photo_pulse_app_bar.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/features/admin/domain/entities/log_entry.dart';
import 'package:photopulse/features/admin/domain/notifiers/logs_notifier.dart';
import 'package:photopulse/features/admin/domain/notifiers/users_notifier.dart';
import 'package:photopulse/features/admin/presentation/widgets/admin_tab_view.dart';
import 'package:photopulse/features/admin/presentation/widgets/user_tile.dart';
import 'package:photopulse/generated/l10n.dart';

class AdminPage extends ConsumerWidget {
  static const routeName = Pages.admin;
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersNotifierProvider);
    final logs = ref.watch(logsNotifierProvider);
    return PhotoPulseScaffold(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.zero),
      appBar: PhotoPulseAppBar.withBackNav(
        onTap: ref.pop,
        title: S.current.admin_panel,
      ),
      body: AdminTabView(
        tabs: [
          Tab(text: S.current.user_statistics),
          Tab(text: S.current.user_actions),
        ],
        children: [
          ListView.separated(
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.bodyPaddingVertical,
              horizontal: AppSizes.bodyPaddingHorizontal,
            ),
            itemCount: users.length,
            itemBuilder: (context, index) {
              return UserTile(user: users[index]);
            },
            separatorBuilder: (context, index) {
              return const Gap(AppSizes.compactSpacing);
            },
          ),
          ListView.separated(
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.bodyPaddingVertical,
              horizontal: AppSizes.bodyPaddingHorizontal,
            ),
            itemCount: logs.length,
            itemBuilder: (context, index) {
              return LogEntryTile(logEntry: logs[index]);
            },
            separatorBuilder: (context, index) {
              return const Gap(AppSizes.compactSpacing);
            },
          ),
        ],
      ),
    );
  }
}

class LogEntryTile extends StatelessWidget {
  final LogEntry logEntry;

  const LogEntryTile({super.key, required this.logEntry});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: BodyText(logEntry.eventType.toUpperCase()),
      subtitle: Text('${logEntry.collection} - ${logEntry.documentId}'),
      trailing: Text(
          DateFormat('dd/MM/yyyy HH:mm').format(logEntry.timestamp.toDate())),
      onTap: () {
        // Implement what happens when you tap on a log entry
        // Possibly navigate to a detailed screen
      },
    );
  }
}
