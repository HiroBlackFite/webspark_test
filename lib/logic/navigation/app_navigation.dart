import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:webspark_test/config/config.dart';
import 'package:webspark_test/ui/screens/screens.dart';

class AppNavigation {
  AppNavigation._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: HomeScreen.route,
    navigatorKey: _rootNavigatorKey,
    observers: [AppConstants.routeObserver],
    routes: [
      GoRoute(
        path: HomeScreen.route,
        name: HomeScreen.name,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: ProcessScreen.route,
        name: ProcessScreen.name,
        builder: (context, state) => const ProcessScreen(),
      ),
      GoRoute(
        path: ResultListScreen.route,
        name: ResultListScreen.name,
        builder: (context, state) => const ResultListScreen(),
      ),
      GoRoute(
          path: PreviewScreen.path,
          name: PreviewScreen.name,
          builder: (context, state) {
            final id = state.pathParameters['id'] ?? '';

            return PreviewScreen(
              id: id,
            );
          }),
    ],
  );
}
