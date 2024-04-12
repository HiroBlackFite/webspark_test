import 'package:flutter/material.dart';

import 'package:webspark_test/config/constants.dart';

mixin RootRouterAware<T extends StatefulWidget> on State<T>, RouteAware {
  bool listenWhen = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppConstants.routeObserver.subscribe(this, ModalRoute.of(context) as Route);
  }

  @override
  void dispose() {
    AppConstants.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    listenWhen = true;
  }

  @override
  void didPushNext() {
    listenWhen = false;
  }
}
