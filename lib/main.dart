import 'package:flutter/material.dart';

import 'package:webspark_test/app.dart';
import 'package:webspark_test/config/config.dart';
import 'package:webspark_test/logic/injection/injection.dart';

void main() async {
  await configureDependencies(env: Env.dev);

  runApp(const App());
}
