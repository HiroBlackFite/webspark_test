import 'package:flutter/material.dart';

class AppOverlays {
  const AppOverlays._();

  static Future onShowDialog(
    BuildContext context, {
    required Widget widget,
  }) async {
    return showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (_) => widget,
    );
  }
}
