import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/photo_pulse_text_form_field.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/features/feed/data/repositories/feed_repository.dart';
import 'package:photopulse/features/feed/domain/notifiers/filters_notifier.dart';
import 'package:photopulse/features/feed/presentation/widgets/user_dropdown.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:photopulse/theme/app_colors.dart';

class FiltersSection extends HookConsumerWidget {
  final VoidCallback onClose;
  const FiltersSection({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final minSizeController = useTextEditingController();
    final maxSizeController = useTextEditingController();

    useEffect(() {
      void onMinSizeChanged() {
        ref.read(filtersNotifierProvider.notifier).addMinImageSize(
              double.tryParse(minSizeController.text),
            );
      }

      void onMaxSizeChanged() {
        ref.read(filtersNotifierProvider.notifier).addMaxImageSize(
              double.tryParse(maxSizeController.text),
            );
      }

      minSizeController.addListener(onMinSizeChanged);
      maxSizeController.addListener(onMaxSizeChanged);

      return () {
        minSizeController.removeListener(onMinSizeChanged);
        maxSizeController.removeListener(onMaxSizeChanged);
      };
    }, [minSizeController, maxSizeController]);

    final filtersNotifier = ref.read(filtersNotifierProvider.notifier);
    final filterState = ref.watch(filtersNotifierProvider);

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
                BodyText(S.current.filter_by_size),
                const SizedBox(
                  height: AppSizes.compactSpacing,
                ),
                Row(
                  children: [
                    Flexible(
                      child: PhotoPulseTextFormField.normalTextField(
                        controller: minSizeController,
                        name: '',
                        labelText: S.current.min_size_in_mb,
                      ),
                    ),
                    const SizedBox(
                      width: AppSizes.mediumSpacing,
                    ),
                    Flexible(
                      child: PhotoPulseTextFormField.normalTextField(
                          controller: maxSizeController,
                          name: '',
                          labelText: S.current.max_size_in_mb),
                    )
                  ],
                ),
                const SizedBox(
                  height: AppSizes.normalSpacing,
                ),
                BodyText(S.current.filter_by_date),
                const SizedBox(
                  height: AppSizes.compactSpacing,
                ),
                Row(
                  children: [
                    Flexible(
                      child: PhotoPulseTextFormField.pickDate(
                        labelText: S.current.select_date_range,
                        name: '',
                        hintText: filterState.dateTimeRange != null
                            ? ref
                                .watch(filtersNotifierProvider)
                                .dateTimeRange!
                                .start
                                .year
                                .toString()
                            : '',
                        textEditingController: TextEditingController(),
                        prefixIcon: const Icon(Icons.date_range),
                        onTap: () async {
                          await _pickDateRange(context, filtersNotifier);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSizes.mediumSpacing,
                ),
                PhotoPulseButton.primary(
                  onTap: () {
                    ref.read(feedRepositoryProvider).getFeed();
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

  Future<void> _pickDateRange(
      BuildContext context, FiltersNotifier filtersNotifier) async {
    final DateTimeRange? dateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 7)),
      ),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.black,
              onPrimary: AppColors.white,
              primaryContainer: AppColors.black.withOpacity(0.2),
              secondaryContainer: AppColors.black.withOpacity(0.2),
              surface: AppColors.white,
              onSurface: AppColors.black,
            ),
            dialogBackgroundColor: AppColors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.black,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    filtersNotifier.addDateTimeRange(dateRange);
  }
}
