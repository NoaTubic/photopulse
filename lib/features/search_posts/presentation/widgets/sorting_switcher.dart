import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/theme/app_colors.dart';

enum SortOrder {
  ascending,
  descending,
}

class SortingSwitcher extends HookWidget {
  final VoidCallback onSortOrderChanged;

  const SortingSwitcher({super.key, required this.onSortOrderChanged});

  @override
  Widget build(BuildContext context) {
    final sortOrder = useState(SortOrder.ascending);

    BoxDecoration buildDecoration(bool isSelected) {
      return BoxDecoration(
        color: isSelected ? AppColors.black : Colors.transparent,
        borderRadius: BorderRadius.circular(AppSizes.normalCircularRadius),
        border: Border.all(color: AppColors.black),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Ascending Tab
        GestureDetector(
          onTap: () {
            if (sortOrder.value != SortOrder.ascending) {
              sortOrder.value = SortOrder.ascending;
              onSortOrderChanged();
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
                vertical: AppSizes.smallSpacing,
                horizontal: AppSizes.normalSpacing),
            decoration: buildDecoration(sortOrder.value == SortOrder.ascending),
            child: Text(
              'Ascending',
              style: TextStyle(
                color: sortOrder.value == SortOrder.ascending
                    ? AppColors.white
                    : AppColors.black,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSizes.smallSpacing),
        // Descending Tab
        GestureDetector(
          onTap: () {
            if (sortOrder.value != SortOrder.descending) {
              sortOrder.value = SortOrder.descending;
              onSortOrderChanged();
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
                vertical: AppSizes.smallSpacing,
                horizontal: AppSizes.normalSpacing),
            decoration:
                buildDecoration(sortOrder.value == SortOrder.descending),
            child: Text(
              'Descending',
              style: TextStyle(
                color: sortOrder.value == SortOrder.descending
                    ? AppColors.white
                    : AppColors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
