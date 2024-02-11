// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/common/presentation/text/text.dart';

import 'package:photopulse/features/auth/domain/notifiers/user_notifier.dart';
import 'package:photopulse/features/feed/domain/notifiers/feed_notifier.dart';
import 'package:photopulse/features/feed/presentation/widgets/post_tile.dart';
import 'package:photopulse/features/search_posts/presentation/pages/search_posts_page.dart';
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
    return PhotoPulseScaffold(
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
              emptyListBuilder: (_) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.remove_circle_rounded,
                    ),
                    const SizedBox(
                      height: AppSizes.smallSpacing,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const BodyText(
                        'There are no posts yet.\nAdd a new one on \'Upload  content Tab\'.',
                        isBold: true,
                        isCentered: true,
                      ),
                    ),
                  ],
                ),
              ),
              onError: (context, asd, a) => const FeedError(),
              scrollPhysics: const BouncingScrollPhysics(),
            ),
          )
        ],
      ),
    );
  }
}
