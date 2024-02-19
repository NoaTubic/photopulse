import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/presentation/animated_widgets/animated_column.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/common/presentation/photo_pulse_text_form_field.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/features/search_posts/domain/notifiers/search_query_provider.dart';
import 'package:photopulse/features/search_posts/presentation/widgets/filters_section.dart';
import 'package:photopulse/features/feed/presentation/widgets/post_tile.dart';
import 'package:photopulse/features/search_posts/domain/notifiers/serach_posts_notifier.dart';
import 'package:photopulse/theme/app_colors.dart';
import 'package:q_architecture/q_architecture.dart';

class SearchPostsPage extends HookConsumerWidget {
  const SearchPostsPage({super.key});

  static const routeName = Pages.searchPosts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchQuery = ref.watch(searchQueryProvider);

    useEffect(() {
      void onTextChanged() {
        ref.read(searchQueryProvider.notifier).state = searchController.text;
      }

      searchController.addListener(onTextChanged);

      return () => searchController.removeListener(onTextChanged);
    }, [searchController]);

    return PhotoPulseScaffold(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.zero,
        vertical: AppSizes.bodyPaddingVertical,
      ),
      body: Column(
        children: [
          AnimatedColumn(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.bodyPaddingHorizontal),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 4,
                      child: PhotoPulseTextFormField.normalTextField(
                        controller: searchController,
                        name: 'name',
                        labelText: 'Search by hashtag',
                        prefixIcon: GestureDetector(
                          onTap: () => searchQuery.isNotEmpty
                              ? ref
                                  .read(searchPostsNotifierProvider.notifier)
                                  .getInitialList()
                              : null,
                          child: Icon(
                            Icons.search_rounded,
                            color: AppColors.black,
                          ),
                        ),
                        suffixIcon: searchQuery.isNotEmpty
                            ? GestureDetector(
                                onTap: () => searchController.clear(),
                                child: Icon(
                                  Icons.close,
                                  color: AppColors.black,
                                ),
                              )
                            : null,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: IconButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              insetPadding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.bodyPaddingHorizontal,
                              ),
                              child: FiltersSection(
                                onClose: () {
                                  ref.pop();
                                },
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.filter_list_rounded, size: 38),
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: PaginatedListView(
              stateNotifierProvider: searchPostsNotifierProvider,
              itemBuilder: (context, post, page) => PostTile(post: post),
              loading: const Center(
                child: CircularProgressIndicator(),
              ),
              emptyListBuilder: (_) => Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      searchQuery.isEmpty
                          ? Icons.search_rounded
                          : Icons.search_off_rounded,
                      size: 32,
                      color: AppColors.black,
                    ),
                    const SizedBox(width: AppSizes.smallSpacing),
                    BodyText(
                      ref.watch(searchQueryProvider).isEmpty
                          ? 'Enter a hashtag to search for posts.'
                          : 'No posts found. Try another hashtag.',
                      isBold: true,
                    ),
                  ],
                ),
              ),
              onError: (_, __, ___) => const FeedError(),
              scrollPhysics: const BouncingScrollPhysics(),
            ),
          )
        ],
      ),
    );
  }
}

class FeedError extends StatelessWidget {
  const FeedError({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_rounded,
          size: 32,
          color: AppColors.black,
        ),
        const SizedBox(width: AppSizes.smallSpacing),
        const BodyText(
          'Something went wrong. Please try again.',
          isBold: true,
        ),
      ],
    );
  }
}
