import 'package:flutter/material.dart';

enum AppSupportedLocale { en }

extension ExtAppSupportedLocale on AppSupportedLocale {
  Locale get locale {
    switch (this) {
      default:
        return const Locale('en');
    }
  }
}

class AppLocales {
  const AppLocales._();

  static const en = 'en';
  static const enLocale = Locale(en);
  static const defaultLocale = enLocale;

  static AppSupportedLocale getAppSupportedLocale(Locale locale) {
    switch (locale.languageCode) {
      default:
        return AppSupportedLocale.en;
    }
  }
}
