import 'package:fluro/fluro.dart';
import 'package:myproject/first_page.dart';
import 'package:myproject/my_demo_page.dart';
import 'package:myproject/others/ui/sliver.dart';
import 'package:myproject/router/routers.dart';
import 'package:myproject/widgets/basics/floating_action_button.dart';
import 'package:myproject/widgets/hero/hero_page.dart';
import 'package:myproject/widgets/hero/hero_test.dart';

Map<String, Handler> routeHandlers = {
  Routes.home: Handler(handlerFunc: (dynamic _, dynamic __) => MyDemoPage()),
  Routes.hero_test: Handler(handlerFunc: (dynamic _, dynamic __) => HeroTest()),
  Routes.hero_page: Handler(handlerFunc: (dynamic _, dynamic __) => HeroPage()),
  Routes.fab_page: Handler(handlerFunc: (dynamic _, dynamic __) => FABPage()),
  Routes.first_page: Handler(handlerFunc: (context, __) {
    return FirstPage();
  }),
  Routes.sliverExample: Handler(handlerFunc: (dynamic _, dynamic __) => SliverAppBarDemo()),
};
