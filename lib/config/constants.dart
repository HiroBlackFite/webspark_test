import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
final BuildContext? _overlayContext = _navigatorKey.currentState?.overlay?.context;
final RouteObserver<Route> _routeObserver = RouteObserver<Route>();

class AppConstants {
  AppConstants._();

  static const String appName = 'Test';
  static const String baseUrl = 'https://flutter.webspark.dev/';
  static const String translationFilePath = 'assets/translations';

  static RouteObserver<Route> get routeObserver => _routeObserver;

  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  static BuildContext? get overlayContext => _overlayContext;
}
