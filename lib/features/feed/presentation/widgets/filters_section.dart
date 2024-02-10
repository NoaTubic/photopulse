import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/photo_pulse_text_form_field.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/common/presentation/user_avatar.dart';
import 'package:photopulse/features/auth/domain/entities/user.dart';
import 'package:photopulse/features/feed/data/repositories/feed_repository.dart';
import 'package:photopulse/features/feed/domain/notifiers/filters_notifier.dart';
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
                      size: 30,
                    ),
                  ),
                ),
                const Center(
                  child: TitleText(
                    'Filters',
                  ),
                ),
                const SizedBox(height: AppSizes.smallSpacing),
                const BodyText('Filter by user'),
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
                const BodyText('Filter by size'),
                const SizedBox(
                  height: AppSizes.compactSpacing,
                ),
                Row(
                  children: [
                    Flexible(
                      child: PhotoPulseTextFormField.normalTextField(
                        controller: minSizeController,
                        name: 'name',
                        labelText: 'Min Size in MB',
                      ),
                    ),
                    const SizedBox(
                      width: AppSizes.mediumSpacing,
                    ),
                    Flexible(
                      child: PhotoPulseTextFormField.normalTextField(
                          controller: maxSizeController,
                          name: 'name',
                          labelText: 'Max Size in MB'),
                    )
                  ],
                ),
                const SizedBox(
                  height: AppSizes.normalSpacing,
                ),
                const BodyText('Filter by date'),
                const SizedBox(
                  height: AppSizes.compactSpacing,
                ),
                Row(
                  children: [
                    Flexible(
                      child: PhotoPulseTextFormField.pickDate(
                        labelText: 'Select date range',
                        name: 'name',
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
                          final DateTimeRange? dateRange =
                              await showDateRangePicker(
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
                                    primaryContainer:
                                        AppColors.black.withOpacity(0.2),
                                    secondaryContainer:
                                        AppColors.black.withOpacity(0.2),
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
                  label: 'Apply filters',
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

class UserDropdown extends ConsumerWidget {
  const UserDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(filtersNotifierProvider).users;
    return DropdownButtonFormField<PhotoPulseUser>(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.normalCircularRadius),
            borderSide: BorderSide(color: AppColors.black)),
      ),
      value: ref.watch(filtersNotifierProvider).selectedUser,
      hint: const BodyText(
        'Select User',
        isBold: true,
      ),
      onChanged: (PhotoPulseUser? user) =>
          ref.read(filtersNotifierProvider.notifier).changeUser(user),
      items: users.map<DropdownMenuItem<PhotoPulseUser>>((PhotoPulseUser user) {
        return DropdownMenuItem<PhotoPulseUser>(
          value: user,
          child: SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserAvatar(
                  user.photoUrl,
                  height: 20,
                  width: 20,
                ),
                const SizedBox(width: AppSizes.smallSpacing),
                Text(user.username),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
