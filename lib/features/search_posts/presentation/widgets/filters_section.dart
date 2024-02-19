import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/features/feed/domain/notifiers/filters_notifier.dart';
import 'package:photopulse/features/feed/presentation/widgets/user_dropdown.dart';
import 'package:photopulse/features/search_posts/domain/notifiers/serach_posts_notifier.dart';
import 'package:photopulse/features/search_posts/presentation/widgets/sorting_switcher.dart';
import 'package:photopulse/generated/l10n.dart';

class FiltersSection extends HookConsumerWidget {
  final VoidCallback onClose;
  const FiltersSection({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filtersNotifier = ref.read(filtersNotifierProvider.notifier);

    return IntrinsicHeight(
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(AppSizes.normalCircularRadius),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.normalSpacing,
                vertical: AppSizes.bodyPaddingVertical),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: onClose,
                    child: const Icon(
                      Icons.close,
                      size: AppSizes.iconMediumSize,
                    ),
                  ),
                ),
                Center(
                  child: TitleText(
                    S.current.filters,
                  ),
                ),
                const SizedBox(height: AppSizes.smallSpacing),
                BodyText(S.current.filter_by_user),
                const SizedBox(height: AppSizes.smallSpacing),
                const Row(
                  children: [
                    Flexible(
                      child: UserDropdown(),
                    ),
                    SizedBox(
                      width: AppSizes.mediumSpacing,
                    ),
                    Flexible(child: SizedBox())
                  ],
                ),
                const SizedBox(
                  height: AppSizes.normalSpacing,
                ),
                BodyText(S.current.sort_by_size),
                const SizedBox(
                  height: AppSizes.compactSpacing,
                ),
                SortingSwitcher(
                  onSortOrderChanged: () {
                    filtersNotifier.toggleSizeDescending();
                  },
                ),
                const SizedBox(
                  height: AppSizes.normalSpacing,
                ),
                BodyText(S.current.sort_by_date),
                const SizedBox(
                  height: AppSizes.compactSpacing,
                ),
                SortingSwitcher(
                  onSortOrderChanged: () {
                    filtersNotifier.toggleDateDescending();
                  },
                ),
                const SizedBox(
                  height: AppSizes.mediumSpacing,
                ),
                PhotoPulseButton.primary(
                  onTap: () {
                    ref
                        .read(searchPostsNotifierProvider.notifier)
                        .getInitialList();
                    ref.pop();
                  },
                  label: S.current.apply_filters,
                ),
                const SizedBox(
                  height: AppSizes.smallSpacing,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
