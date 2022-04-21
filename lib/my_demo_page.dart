import 'package:flutter/material.dart';
import 'package:myproject/my_demo/bottomsheet/bottomsheet_with_fluro.dart';
import 'package:myproject/my_demo/input_scroll_page.dart';
import 'package:myproject/my_demo/pictures/image_cropping_page.dart';
import 'package:myproject/router/my_router.dart';
import 'package:myproject/router/routers.dart';

import 'my_demo/address_picker_page.dart';
import 'my_demo/animate_nstar.dart';
import 'my_demo/ball_run_view_page.dart';
import 'my_demo/balls_run_page.dart';
import 'my_demo/basics/text_learn.dart';
import 'my_demo/draw_chessboard_page.dart';
import 'my_demo/extra_option_edit_list.dart';
import 'my_demo/home_indicator_page.dart';
import 'my_demo/list/reorder_list_page.dart';
import 'my_demo/marquee_page.dart';
import 'my_demo/nice_border_with_wave.dart';
import 'my_demo/num_clock_page.dart';
import 'my_demo/todo_list.dart';

class MyDemoPage extends StatefulWidget {
  const MyDemoPage({Key? key}) : super(key: key);

  @override
  _MyDemoPageState createState() => _MyDemoPageState();
}

class _MyDemoPageState extends State<MyDemoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("项目列表"),
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.5,
        ),
        children: [
          itemGuide('首页引导动画', HomeIndicatorPage()),
          itemGuide('画棋盘、N角星', ChessBoardPage()),
          itemGuide('n角星动画-动起来', AnimateNStar()),
          itemGuide('粒子运动', BallRunPage()),
          itemGuide('balls', BallsRunPage()),
          itemGuide('数字时钟', NumClockPage()),
          itemGuide('文字轮播', MarqueePage()),
          itemGuide('画一个很好看的框', BorderWithWave()),
          itemGuide('三级地址选择器', AddressPickerPage()),
          //itemGuide('hero动画', HeroTest()),
          GestureDetector(
            onTap: () => MyRouter.to(context, Routes.hero_test),
            child: Container(
              width: 100,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                'hero动画',
                style: TextStyle(
                  decorationStyle: TextDecorationStyle.dashed,
                  decorationColor: Colors.teal,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Colors.blue),
              ),
            ),
          ),
          //itemGuide('deck插件', DeckPage()),
          itemGuide('基础源码', TextLearn()),
          itemGuide('可排序的列表', ReOrderListPage()),
          itemGuide('可排序的列表', ExtraOptionsEditList()),
          itemGuide('Widget测试-todolist', TodoList()),
          itemGuide('输入框置顶', InputScrollPage()),
          itemGuide('图片裁剪', ImageCroppingPage()),
          itemGuide("bottomsheet with fluro", BottomsheetWithFluro()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget itemGuide(String text, Widget toPage) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => toPage));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Text(text),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Colors.blue),
          gradient: LinearGradient(colors: [
            Colors.deepOrangeAccent.withOpacity(0.5),
            Colors.orangeAccent.withOpacity(0.5),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
      ),
    );
  }
}
