import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:webspark_test/localization/locale_keys.g.dart';
import 'package:webspark_test/logic/extensions/extensions.dart';
import 'package:webspark_test/ui/widgets/overlays/widgets/widgets.dart';
import 'package:webspark_test/ui/widgets/widget.dart';

class AppDialogs {
  static Future error(
    BuildContext context, {
    String? title,
    String? message,
    VoidCallback? onCloseDialog,
  }) async {
    return AppOverlays.onShowDialog(
      context,
      widget: AppAlert(
        title: title ?? LocaleKeys.global_error.tr().capitalizeFirstLetter(),
        message: message,
        actions: [
          AppButtons.primary(
            title: LocaleKeys.global_close.tr(),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              onCloseDialog?.call();
            },
          ),
        ],
      ),
    );
  }
}
