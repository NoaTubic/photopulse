import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/common/presentation/text/title_text.dart';
import 'package:photopulse/common/presentation/user_avatar.dart';
import 'package:photopulse/features/feed/presentation/widgets/feed_image.dart';
import 'package:photopulse/features/post/domain/entities/post.dart';
import 'package:photopulse/features/post/domain/notifiers/download_post_content_notifier.dart';
import 'package:photopulse/features/post/presentation/pages/post_page.dart';
import 'package:photopulse/theme/app_colors.dart';
import 'package:photopulse/theme/theme.dart';
import 'package:readmore/readmore.dart';

class PostTile extends StatelessWidget {
  final Post post;
  const PostTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(AppSizes.compactSpacing),
        _PostHeader(
          post: post,
        ),
        const Gap(AppSizes.compactSpacing),
        FeedImage(id: post.id ?? '-1', imageUrl: post.url),
        const Gap(AppSizes.smallSpacing),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.normalSpacing,
          ),
          child: Row(
            children: [
              BodyText(
                post.author.username,
                isBold: true,
              ),
              const Gap(AppSizes.tinySpacing),
              BodyText(
                post.title,
                isBold: false,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.normalSpacing,
          ),
          child: _PostDescription(post.caption),
        ),
      ],
    );
  }
}

class _PostDescription extends StatelessWidget {
  final String caption;

  const _PostDescription(this.caption);

  @override
  Widget build(BuildContext context) {
    final commentStyle = Theme.of(context).textTheme.bodyMedium;
    final actionStyle =
        commentStyle?.copyWith(color: Theme.of(context).colorScheme.secondary);
    return ReadMoreText(
      caption,
      trimLines: 2,
      trimMode: TrimMode.Line,
      trimCollapsedText: '\n${'View more'}',
      trimExpandedText: '\n${'View less'}',
      style: commentStyle,
      moreStyle: actionStyle,
      lessStyle: actionStyle,
      colorClickableText: Theme.of(context).colorScheme.secondary,
    );
  }
}

class _PostHeader extends ConsumerWidget {
  final Post post;

  const _PostHeader({
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme.labelMedium?.copyWith(
          color: AppColors.black,
        );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Gap(AppSizes.normalSpacing),
        Expanded(
          child: GestureDetector(
            onTap: () {
              // if (!post.author.canViewProfile) return;
              // ref
              //     .read(viewUserProfileProvider.notifier)
              //     .getUserProfile(post.author.id);
              // Navigator.of(context).pushNamed(ViewUserPage.routeName);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserAvatar(
                  post.author.photoUrl,
                  height: AppSizes.smallAvatarRadius,
                  width: AppSizes.smallAvatarRadius,
                ),
                const Gap(AppSizes.smallSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyText(
                        post.author.username,
                        isBold: true,
                      ),
                      // Text(post.createdAt.toDate().toLocal().toString(),
                      //     style: style),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // if (ref.watch(familyFeedNotifierProvider).maybeWhen(
        //       orElse: () => false,
        //       data: (familyFeed) =>
        //           familyFeed.relation == UserRole.poa && familyFeed.isActive,
        //     ))
        Theme(
          data: ThemeData(
            splashColor: AppColors.black.withOpacity(0.1),
            highlightColor: AppColors.black.withOpacity(0.1),
          ),
          child: PopupMenuButton(
            color: AppColors.white,
            surfaceTintColor: AppColors.white,
            itemBuilder: (context) {
              return FeedMenuItem.values
                  .map((item) => _buildPopupMenuItem(item))
                  .toList();
            },
            onSelected: (value) {
              if (value == FeedMenuItem.editPost) {
                _editPost(context, post);
              } else if (value == FeedMenuItem.download) {
                _downloadPostContent(ref, post);
              }
            },
          ),
        ),
      ],
    );
  }

  void _editPost(BuildContext context, Post post) =>
      Navigator.of(context).pushNamed(
        PostPage.routeName,
        arguments: post,
      );

  void _downloadPostContent(WidgetRef ref, Post post) => ref
      .read(downloadPostContentNotifierProvider(post.id ?? '-1').notifier)
      .downloadContent(
        url: post.url,
        title: post.title,
      );

  // void _showHidePostDialog(BuildContext context, WidgetRef ref) => showDialog(
  //       context: context,
  //       builder: (context) => CareConnectDialog(
  //         title: S.current.post_hide_checker,
  //         topButtonText: S.current.post_hide_confirm,
  //         topButtonAction: () => _hidePost(ref, post.id ?? -1),
  //         cancelButtonText: S.current.label_cancel,
  //       ),
  //     );

  // void _hidePost(WidgetRef ref, int id) {
  //   ref.read(isPostHidden(id).notifier).state = true;
  //   ref.read(postNotifierProvider.notifier).hidePost(id);
  // }

  PopupMenuItem _buildPopupMenuItem(FeedMenuItem item) {
    return PopupMenuItem<FeedMenuItem>(
      value: item,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(item.icon),
          const SizedBox(
            width: AppSizes.smallSpacing,
          ),
          BodyText(
            item.title,
          ),
        ],
      ),
    );
  }
}

enum FeedMenuItem {
  editPost(icon: Icons.edit_rounded),
  download(icon: Icons.download_rounded);

  const FeedMenuItem({
    required this.icon,
  });

  final IconData icon;

  String get title {
    switch (this) {
      case FeedMenuItem.editPost:
        return 'Edit post';
      case FeedMenuItem.download:
        return 'Download post';
    }
  }
}
