import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_text_button.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/common/presentation/user_avatar.dart';
import 'package:photopulse/common/utils/date_time_extensions.dart';
import 'package:photopulse/features/feed/presentation/pages/home_page.dart';
import 'package:photopulse/features/feed/presentation/widgets/feed_image.dart';
import 'package:photopulse/features/map/presentation/pages/map_page.dart';
import 'package:photopulse/features/post/domain/entities/post.dart';
import 'package:photopulse/features/post/domain/notifiers/download_post_content_notifier.dart';
import 'package:photopulse/features/post/domain/notifiers/hashtag_notifer.dart';
import 'package:photopulse/features/post/domain/notifiers/post_notifier.dart';
import 'package:photopulse/features/post/presentation/pages/post_page.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:photopulse/theme/app_colors.dart';
import 'package:readmore/readmore.dart';
import 'package:photopulse/features/auth/domain/notifiers/user_notifier.dart';

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
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.normalSpacing,
          ),
          child: BodyText(
            post.tags.join(' '),
            color: AppColors.black,
            isBold: true,
          ),
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
      trimCollapsedText: '\n${S.current.view_more}',
      trimExpandedText: '\n${S.current.view_less}',
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Gap(AppSizes.normalSpacing),
        Expanded(
          child: GestureDetector(
            onTap: null,
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
                      BodyText(post.createdAt.toDate().postLabel)
                    ],
                  ),
                ),
                PhotoPulseTextButton(
                  label: post.location?.name ?? '',
                  onTap: () => ref.pushNamed(
                      '${HomePage.routeName}${MapPage.routeName}',
                      data: post.location),
                ),
              ],
            ),
          ),
        ),
        Theme(
          data: ThemeData(
            splashColor: AppColors.black.withOpacity(0.1),
            highlightColor: AppColors.black.withOpacity(0.1),
          ),
          child: PopupMenuButton(
            color: AppColors.white,
            surfaceTintColor: AppColors.white,
            itemBuilder: (context) {
              if (ref.watch(isAnonymousProvider) ||
                  (ref.read(userProvider)!.id != post.author.id &&
                      ref.read(userProvider)!.isAdmin == false)) {
                return [
                  _buildPopupMenuItem(FeedMenuItem.download),
                ];
              } else if (ref.read(userProvider)!.isAdmin == true) {
                return FeedMenuItem.values
                    .map((item) => _buildPopupMenuItem(item))
                    .toList();
              } else {
                return FeedMenuItem.values
                    .map((item) => _buildPopupMenuItem(item))
                    .toList();
              }
            },
            onSelected: (value) {
              if (value == FeedMenuItem.editPost) {
                _editPost(post, ref);
              } else if (value == FeedMenuItem.download) {
                _downloadPostContent(ref, post);
              } else {
                _deletePost(post, ref);
              }
            },
          ),
        ),
      ],
    );
  }

  void _editPost(Post post, WidgetRef ref) {
    ref.read(hashtagNotifierProvider.notifier).getHashtags(post.id);
    ref.pushNamed('${HomePage.routeName}${PostPage.routeName}', data: post);
  }

  void _downloadPostContent(WidgetRef ref, Post post) => ref
      .read(downloadPostContentNotifierProvider(post.id ?? '-1').notifier)
      .downloadContent(
        url: post.url,
        title: post.title,
      );

  void _deletePost(Post post, WidgetRef ref) {
    ref.read(postNotifierProvider.notifier).deletePost(post);
  }

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
  download(icon: Icons.download_rounded),
  delete(icon: Icons.delete_rounded);

  const FeedMenuItem({
    required this.icon,
  });

  final IconData icon;

  String get title {
    switch (this) {
      case FeedMenuItem.editPost:
        return S.current.edit_post;
      case FeedMenuItem.download:
        return S.current.delete_post;
      case FeedMenuItem.delete:
        return S.current.delete_post;
    }
  }
}
