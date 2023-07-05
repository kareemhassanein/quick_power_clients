import 'package:flutter/cupertino.dart';

import 'Language/LanguageAr.dart';
import 'Language/LanguageEn.dart';
import 'Language/Languages.dart';


class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'ar':
        return LanguageAr();
      default:
        return LanguageAr();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}