import 'package:flutter/material.dart';
import 'package:photopulse/common/constants/localization_constants.dart';
import 'package:photopulse/generated/l10n.dart';

extension LocaleExtensions on Locale {
  String fullName() {
    switch (languageCode) {
      case LocalizationConstants.croatianLanguage:
        return S.current.croatian;

      case LocalizationConstants.englishLanguage:
        return S.current.english;
    }
    return '';
  }
}
