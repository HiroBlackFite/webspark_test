import 'package:flutter/cupertino.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:webspark_test/config/config.dart';
import 'package:webspark_test/logic/utils/utils.dart';

class LocalizationWrapper extends StatefulWidget {
  final Widget child;

  const LocalizationWrapper({super.key, required this.child});

  @override
  State<LocalizationWrapper> createState() => _LocalizationWrapperState();
}

class _LocalizationWrapperState extends State<LocalizationWrapper> {
  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [AppLocales.enLocale],
      path: AppConstants.translationFilePath,
      fallbackLocale: AppLocales.enLocale,
      child: widget.child,
    );
  }
}
