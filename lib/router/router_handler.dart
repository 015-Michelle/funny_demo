import 'package:fluro/fluro.dart';
import 'package:myproject/home_page.dart';
import 'package:myproject/router/routers.dart';
import 'package:myproject/widgets/basics/floating_action_button.dart';
import 'package:myproject/widgets/hero/hero_page.dart';
import 'package:myproject/widgets/hero/hero_test.dart';

Map<String, Handler> routeHandlers = {
  Routes.root: Handler(handlerFunc: (dynamic _, dynamic __) => HomePage()),
  Routes.home: Handler(handlerFunc: (dynamic _, dynamic __) => HomePage()),
  Routes.hero_test: Handler(handlerFunc: (dynamic _, dynamic __) => HeroTest()),
  Routes.hero_page: Handler(handlerFunc: (dynamic _, dynamic __) => HeroPage()),
  Routes.fab_page: Handler(handlerFunc: (dynamic _, dynamic __) => FABPage()),
};
