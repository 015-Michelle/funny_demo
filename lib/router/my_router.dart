import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import 'router_handler.dart';

class MyRouter {
  static late FluroRouter router;

  static init() {
    router = FluroRouter();
    _configureRoutes();
  }

  static _configureRoutes() {
    // 找不到 Handler
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
        print('找不到页面');
        return null;
      },
    );

    // 配置
    routeHandlers.forEach((name, handler) => router.define(name, handler: handler));
  }

  static Future to(
    BuildContext context,
    String path, {
    bool rootNavigator = false,
    bool clearStack = false,
    bool replace = false,
    Map<String, dynamic>? arguments,
    String? removeUntil,
    TransitionType transitionType = TransitionType.cupertino,
  }) {
    RouteSettings? routeSettings;
    if (arguments != null) {
      routeSettings = RouteSettings(arguments: arguments);
    }

    if (removeUntil != null) {
      popUntil(context, removeUntil);
    }

    return router.navigateTo(
      context,
      path,
      transition: transitionType,
      transitionBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      transitionDuration:
          transitionType != TransitionType.cupertino ? Duration(milliseconds: 300) : null,
      rootNavigator: rootNavigator,
      clearStack: clearStack,
      replace: replace,
      routeSettings: routeSettings,
    );
  }

  static popUntil(BuildContext context, String until) {
    Navigator.of(context).popUntil((route) {
      return route.settings.name != null && route.settings.name!.startsWith(until);
    });
  }
}

extension UrlExt on String {
  String get encode => Uri.encodeComponent(this);

  String get decode => Uri.decodeComponent(this);
}
