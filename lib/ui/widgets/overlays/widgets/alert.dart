import 'package:flutter/material.dart';

import 'package:webspark_test/ui/widgets/overlays/widgets/widgets.dart';

class AppAlert extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final String? message;
  final Widget? content;
  final List<Widget>? actions;

  const AppAlert({
    super.key,
    this.title,
    this.titleWidget,
    this.message,
    this.content,
    this.actions,
  })  : assert(
          (message == null) ^ (content == null),
          'message and content are mutually exclusive',
        ),
        assert(
          (title == null) ^ (titleWidget == null),
          'title and titleWidget are mutually exclusive',
        );

  @override
  Widget build(BuildContext context) {
    final title_ = title;
    final titleWidget_ = titleWidget;
    final message_ = message;
    final content_ = content;
    final actions_ = actions;

    final widgetTitle =
        title_ != null && titleWidget_ == null ? OverlayText.title(title_) : titleWidget_;
    final widgetContent =
        message_ != null && content_ == null ? OverlayText.message(message_) : content_;

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widgetTitle != null) widgetTitle,
        ],
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      actionsAlignment: MainAxisAlignment.center,
      alignment: Alignment.center,
      titlePadding: const EdgeInsets.only(top: 16),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      actionsPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widgetContent != null) widgetContent,
        ],
      ),
      actions: <Widget>[
        if (actions_ != null) ...actions_,
      ],
    );
  }
}
