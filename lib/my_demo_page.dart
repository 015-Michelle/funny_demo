import 'package:flutter/material.dart';
import 'package:myproject/first_page.dart';
import 'package:myproject/router/my_router.dart';
import 'package:myproject/router/routers.dart';
import 'package:myproject/widgets/ball_run_view_page.dart';
import 'package:myproject/widgets/basics/text_learn.dart';
import 'package:myproject/widgets/draw_chessboard_page.dart';
import 'package:myproject/widgets/extra_option_edit_list.dart';
import 'package:myproject/widgets/list/reorder_list_page.dart';
import 'package:myproject/widgets/marquee_page.dart';
import 'package:myproject/widgets/num_clock_page.dart';
import 'package:myproject/widgets/todo_list.dart';

import 'widgets/address_picker_page.dart';
import 'widgets/animate_nstar.dart';
import 'widgets/balls_run_page.dart';
import 'widgets/deck_page.dart';
import 'widgets/home_indicator_page.dart';
import 'widgets/nice_border_with_wave.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
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
                        decorationStyle: TextDecorationStyle.dashed, decorationColor: Colors.teal),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.blue),
                  ),
                ),
              ),
              itemGuide('deck插件', DeckPage()),
              itemGuide('基础源码', TextLearn()),
              itemGuide('可排序的列表', ReOrderListPage()),
              itemGuide('可排序的列表', ExtraOptionsEditList()),
              itemGuide('Widget测试-todolist', TodoList()),
              itemGuide('Sliver', FirstPage()),
            ],
          ),
        ),
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
        ),
      ),
    );
  }
}
