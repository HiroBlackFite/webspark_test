import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:webspark_test/localization/locale_keys.g.dart';
import 'package:webspark_test/logic/extensions/extensions.dart';
import 'package:webspark_test/logic/services/services.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validate;
  final Widget? prefixIcon;

  const AppTextField._({
    required this.controller,
    this.hintText,
    this.validate,
    this.prefixIcon,
  });

  factory AppTextField.baseUrl({
    required TextEditingController controller,
  }) =>
      AppTextField._(
        controller: controller,
        hintText: LocaleKeys.homeScreen_baseUrl_hintText.tr(),
        validate: AppValidations.baseUrl,
        prefixIcon: const Icon(Icons.compare_arrows),
      );

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final _focusNode = FocusNode();
  final _formFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: Builder(
        builder: (context) {
          return TextFormField(
            key: _formFieldKey,
            controller: widget.controller,
            cursorColor: context.colorScheme.onPrimary,
            validator: widget.validate,
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              hintText: widget.hintText,
              hintStyle: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onPrimaryContainer,
              ),
            ),
          );
        },
      ),
    );
  }
}
