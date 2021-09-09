import 'package:flutter/material.dart';
import 'package:myproject/router/my_router.dart';

import 'home_page.dart';

void main() => (runApp(MyApp()));

class MyApp extends StatelessWidget {
  MyApp({Key? key}) {
    MyRouter.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: HomePage(),
    );
  }
}
