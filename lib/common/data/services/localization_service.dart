import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/constants/localization_constants.dart';
import 'package:photopulse/common/data/services/local_storage_service.dart';
import 'package:photopulse/generated/l10n.dart';

final localizationServiceProvider = Provider<LocalizationService>(
  (ref) => LocalizationServiceImpl(ref.watch(localStorageServiceProvider)),
);

abstract class LocalizationService {
  Future<void> changeLanguage(Locale language);

  Future<String> loadLanguage();

  Locale getDefault();
}

class LocalizationServiceImpl implements LocalizationService {
  final LocalStorageService _localStorageService;

  LocalizationServiceImpl(this._localStorageService);

  @override
  Future<void> changeLanguage(Locale language) async {
    await _localStorageService.writeLocalization(
      language.toLanguageTag(),
    );
  }

  @override
  Future<String> loadLanguage() async {
    final String languageTag =
        await _localStorageService.readLocalization('') ??
            LocalizationConstants.englishLanguage;

    final locale = languageTag.isNotEmpty ? Locale(languageTag) : getDefault();
    _loadLanguage(locale);

    return locale.languageCode;
  }

  @override
  Locale getDefault() {
    const appLocalizationDelegate = AppLocalizationDelegate();

    final systemLocaleNameParts = kIsWeb ? [] : Platform.localeName.split('_');

    final systemLanguageCode =
        systemLocaleNameParts.isNotEmpty ? systemLocaleNameParts.first : null;
    return appLocalizationDelegate.supportedLocales.firstWhere(
      (locale) => locale.languageCode == systemLanguageCode,
      orElse: () => appLocalizationDelegate.supportedLocales.first,
    );
  }

  Future<void> _loadLanguage(Locale language) async {
    S.load(language);
  }
}
