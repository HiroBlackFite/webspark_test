import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:webspark_test/logic/extensions/extensions.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppHeader({
    super.key,
    required this.title,
  });

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: context.colorScheme.onPrimary,
      ),
      backgroundColor: context.colorScheme.primary,
      title: Text(
        title,
        style: context.textTheme.titleLarge?.copyWith(
          color: context.colorScheme.onPrimary,
        ),
      ).tr(),
    );
  }
}
