import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:webspark_test/localization/locale_keys.g.dart';
import 'package:webspark_test/logic/models/models.dart';
import 'package:webspark_test/ui/widgets/overlays/dialogs/app_dialogs.dart';

part 'server_error_handler.dart';

Future errorHandler(
  BuildContext context, {
  AppError? error,
}) async {
  if (error == null) return;

  return error.whenOrNull<Future>(
    customError: (message) {
      return AppDialogs.error(context, message: message);
    },
    server: (error) => _serverErrorHandler(context, error),
    noInternetConnection: () {
      return AppDialogs.error(
        context,
        message: LocaleKeys.global_noInternetConnection.tr(),
      );
    },
    timeout: () {
      return AppDialogs.error(
        context,
        message: LocaleKeys.global_connectingTimedOut.tr(),
      );
    },
    unhandledError: (error) {
      return _showSomethingWentWrong(context);
    },
    parsingModel: (error) {
      return _showSomethingWentWrong(context);
    },
  );
}

Future getErrorMessage(BuildContext context, String? message) => AppDialogs.error(
      context,
      message: message ?? LocaleKeys.global_connectingTimedOut.tr(),
    );

Future _showSomethingWentWrong(BuildContext context) async => AppDialogs.error(
      context,
      message: LocaleKeys.global_somethingWentWrong.tr(),
    );
