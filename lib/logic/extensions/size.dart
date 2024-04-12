import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  Size get screen => MediaQuery.of(this).size;

  EdgeInsets get padding => MediaQuery.of(this).padding;
}
