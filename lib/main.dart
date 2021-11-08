import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject/examples_demo_page.dart';
import 'package:myproject/first_page.dart';
import 'package:myproject/my_demo_page.dart';
import 'package:myproject/router/my_router.dart';
import 'package:myproject/test_demo_page.dart';

//void main() => (runApp(MyApp()));

///use GetX
void main() => runApp(
      GetMaterialApp(
        initialRoute: '/first',
        getPages: [
          GetPage(name: '/first', page: () => FirstPage()),
          GetPage(name: '/my', page: () => MyDemoPage()),
          GetPage(name: '/examples', page: () => ExamplesDemoPage()),
          GetPage(name: '/test', page: () => TestDemoPage()),
        ],
      ),
    );

class MyApp extends StatelessWidget {
  MyApp({Key? key}) {
    MyRouter.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: FirstPage(),
    );
  }
}
