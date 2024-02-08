// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/domain/router/pages.dart';

import 'package:photopulse/features/auth/domain/notifiers/user_notifier.dart';
import 'package:photopulse/features/feed/domain/notifiers/feed_notifier.dart';
import 'package:photopulse/features/feed/presentation/widgets/post_tile.dart';
import 'package:photopulse/features/subscription_management/presentation/pages/subscription_management_page.dart';
import 'package:q_architecture/q_architecture.dart';

class HomePage extends ConsumerWidget {
  static const routeName = Pages.home;

  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    ref.listen(userProvider, (_, next) {
      if (next != null && next.isFirstLogin) {
        ref.pushReplacementNamed(
          SubscriptionManagementPage.routeName,
        );
      }
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: PaginatedListView(
              stateNotifierProvider: feedNotifierProvider,
              itemBuilder: (context, post, page) => PostTile(post: post),
              loading: const Center(
                child: CircularProgressIndicator(),
              ),
              emptyListBuilder: (context) => Container(),
              onError: (context, asd, a) => const Text('errror'),
              scrollPhysics: const BouncingScrollPhysics(),
            ),
          )
        ],
      ),
    );
  }
}
