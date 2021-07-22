import 'package:flutter/material.dart';
import 'package:myproject/draw_chessboard_page.dart';

import 'animate_nstar.dart';
import 'home_indicator_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("项目列表"),
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomeIndicatorPage()));
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  "首页引导动画",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ChessBoardPage()));
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  "画棋盘、n角星",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AnimateNStar()));
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  "n角星动画-动起来",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
