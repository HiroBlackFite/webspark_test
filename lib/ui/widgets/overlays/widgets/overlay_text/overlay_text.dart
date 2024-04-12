import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webspark_test/logic/extensions/extensions.dart';

part 'overlay_text.freezed.dart';

@freezed
class OverlayStyle with _$OverlayStyle {
  const factory OverlayStyle.title() = _Title;

  const factory OverlayStyle.message() = _Message;
}

class OverlayText extends StatelessWidget {
  final String title;
  final OverlayStyle style;
  final TextAlign textAlign;

  const OverlayText._({
    required this.title,
    required this.style,
    this.textAlign = TextAlign.center,
  });

  factory OverlayText.title(
    String text, {
    TextAlign textAlign = TextAlign.center,
  }) =>
      OverlayText._(title: text, style: const OverlayStyle.title(), textAlign: textAlign);

  factory OverlayText.message(String text) =>
      OverlayText._(title: text, style: const OverlayStyle.message());

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: style.when(
        title: () => context.textTheme.displayMedium,
        message: () => context.textTheme.headlineLarge,
      ),
    );
  }
}
