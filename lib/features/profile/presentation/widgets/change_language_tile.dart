import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/constants/localization_constants.dart';
import 'package:photopulse/common/domain/entities/language_item.dart';
import 'package:photopulse/common/domain/notifiers/localization_notifier.dart';
import 'package:photopulse/common/domain/utils/locale_extension.dart';
import 'package:photopulse/common/presentation/base_dropdown_button.dart';
import 'package:photopulse/common/presentation/photo_pulse_tile.dart';
import 'package:photopulse/generated/l10n.dart';

class ChangeLanguageTile extends ConsumerWidget {
  const ChangeLanguageTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizationNotifier =
        ref.read(localizationNotifierProvider.notifier);
    final localizationState = ref.watch(localizationNotifierProvider);

    final List<LanguageItem> languages = [
      LanguageItem(
        locale: const Locale(LocalizationConstants.englishLanguage),
        language: S.current.english,
      ),
      LanguageItem(
        locale: const Locale(LocalizationConstants.croatianLanguage),
        language: S.current.croatian,
      ),
    ];

    return PhotoPulseTile(
      icon: Icons.language_rounded,
      onTap: null,
      label: S.current.change_language,
      action: BaseDropdownButton(
        onChanged: (item) async {
          final selectedItem = item as String;
          await localizationNotifier
              .changeLanguage(
                localizationNotifier.getLocale(selectedItem, languages),
              )
              .whenComplete(() => localizationNotifier.loadLanguage());
        },
        hint: localizationState.fullName(),
        items: addDividersAfterItems(
          languages.map((e) => e.language).toList(),
          context,
        ),
        customItemsHeights: getCustomItemsHeights(
          languages.map((e) => e.language).toList(),
        ),
      ),
    );
  }
}
