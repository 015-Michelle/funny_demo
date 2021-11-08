import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_painte_page.dart';

class ChessBoardPage extends StatefulWidget {
  const ChessBoardPage({Key? key}) : super(key: key);

  @override
  _ChessBoardPageState createState() => _ChessBoardPageState();
}

class _ChessBoardPageState extends State<ChessBoardPage> {
  late Color starColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的棋盘"),
      ),
      body: GestureDetector(
        child: CustomPaint(
          painter: CustomPaintePage(
            Rect.zero,
            (canvas) {
              Paint paint = Paint()
                ..style = PaintingStyle.stroke
                ..color = Colors.green
                ..strokeWidth = 1;
              canvas.drawPath(gridPath(20, MediaQuery.of(context).size), paint);
              Paint paintXY = Paint()
                ..style = PaintingStyle.stroke
                ..color = starColor
                ..strokeWidth = 3;
              Path pathXX = drawNStar(7, 50, 30, Offset(100, 100));
              canvas.drawPath(pathXX, paintXY);
            },
          ),
        ),
        onTap: () {
          setState(() {
            starColor = randomRGB();
          });
        },
      ),
    );
  }
}
