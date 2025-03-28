import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'route_arguments.dart';

class AppRoutes {
  static String get splash => '/';
  static String get register => '/register';
  static String get home => '/home';
  static String get login => '/login';

  static List<String> transparentRoutes = [];
  static getRoute(RouteSettings settings) {
    Widget widget;
    try {
      widget = GetIt.I.get<Widget>(instanceName: settings.name);
    } catch (e) {
      widget = Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Builder(
            builder: (context) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
                child: Text(
                  '404 NOT FOUND',
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
      );
    }

    final opaque = (settings.arguments is RouteArguments &&
        (settings.arguments as RouteArguments).opaque);
    return PageRouteBuilder(
        opaque: opaque,
        pageBuilder: (_, __, ___) => widget,
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return Align(
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        settings: settings);
  }
}
