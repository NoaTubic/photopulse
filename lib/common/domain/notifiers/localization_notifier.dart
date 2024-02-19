import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/data/services/localization_service.dart';
import 'package:photopulse/common/domain/entities/language_item.dart';

final localizationNotifierProvider =
    StateNotifierProvider<LocalizationNotifier, Locale>(
  (ref) => LocalizationNotifier(
    ref.watch(localizationServiceProvider),
  )..loadLanguage(),
);

class LocalizationNotifier extends StateNotifier<Locale> {
  final LocalizationService _localizationService;

  LocalizationNotifier(this._localizationService)
      : super(_localizationService.getDefault());

  Future<void> changeLanguage(Locale language) async {
    await _localizationService.changeLanguage(language);
    state = language;
  }

  Future<void> loadLanguage() async {
    final locale = await _localizationService.loadLanguage();
    try {
      state = Locale(locale);
    } catch (_) {}
  }

  Locale getLocale(String selectedLanguage, List<LanguageItem> languages) {
    final locale = languages
        .where(
          (language) => language.language == selectedLanguage,
        )
        .first;
    return locale.locale;
  }
}
