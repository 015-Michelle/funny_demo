import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject/router/my_router.dart';
import 'package:myproject/router/routers.dart';

class HeroTest extends StatefulWidget {
  const HeroTest({Key? key}) : super(key: key);

  @override
  _HeroTestState createState() => _HeroTestState();
}

class _HeroTestState extends State<HeroTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A'),
      ),
      body: Column(
        children: [
          //         Expanded(
          //           child: Hero(
          //             tag: 'tag',
          //             child: Image.asset(
          //               'assets/ic_hero.jpg',
          //               fit: BoxFit.fill,
          //             ),
          //             transitionOnUserGestures: true,
          //           ),
          //         ),
          //         CupertinoButton(
          //           child: Text('点啊'),
          //           onPressed: () => MyRouter.to(context, Routes.hero_page),
          //         ),
          //       ],
          //     ),
          //   );
          // }
          Expanded(
            flex: 1,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Hero(
                    tag: 'tag',
                    child: Image.asset(
                      'assets/ic_hero.jpg',
                      fit: BoxFit.fill,
                    ))),
          ),

          SizedBox(height: 18),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.of(context).pop(),
                child: Icon(Icons.clear),
              ),
              SizedBox(width: 162),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => _onPressedOk(context),
                child: Icon(Icons.done),
              ),
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  /// 确认点击事件
  void _onPressedOk(BuildContext context) async {
    MyRouter.to(
      context,
      Routes.hero_page,
    );
  }
}
