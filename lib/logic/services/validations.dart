import 'package:easy_localization/easy_localization.dart';

import 'package:webspark_test/localization/locale_keys.g.dart';

class AppValidations {
  AppValidations._();

  static String? baseUrl(String? value) {
    if (value == null) return value;
    if (value.isEmpty) return LocaleKeys.homeScreen_baseUrl_IsRequired.tr();
    if (!Uri.parse(value).isAbsolute) return LocaleKeys.homeScreen_baseUrl_incorrectFormat.tr();

    return null;
  }
}
