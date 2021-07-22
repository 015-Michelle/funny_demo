import 'dart:math';

import 'package:flutter/material.dart';

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
          size: MediaQuery.of(context).size,
          painter: DrawChessBoradPage(context, starColor),
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

class DrawChessBoradPage extends CustomPainter {
  BuildContext context;
  Color startColor;

  DrawChessBoradPage(this.context, this.startColor);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.green
      ..strokeWidth = 1;
    canvas.drawPath(gridPath(20, size), paint);
    Paint paintXY = Paint()
      ..style = PaintingStyle.stroke
      ..color = startColor
      ..strokeWidth = 3;
    // Path pathXY = Path();
    // pathXY.moveTo(size.height / 2, 0);
    // pathXY.lineTo(size.height / 2, size.width);
    // // pathXY.moveTo(0, size.width / 2);
    // // pathXY.lineTo(size.height, size.width / 2);
    // canvas.drawPath(pathXY, paintXY);
    Path pathXX = drawStar(7, 50, 30, 100);
    canvas.drawPath(pathXX, paintXY);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  Path gridPath(int step, Size size) {
    Path path = new Path();
    int i = 0;
    for (i = 0; i < size.height / step + 1; i++) {
      path.moveTo(0, step * i.toDouble());
      path.lineTo(size.width, step * i.toDouble());
    }
    for (i = 0; i < size.width / step + 1; i++) {
      path.moveTo(step * i.toDouble(), 0);
      path.lineTo(step * i.toDouble(), size.height);
    }
    return path;
  }

  //画五角星
  Path drawStar(int num, double R, double r, int offsetPosition) {
    double perDeg = 360 / num;
    Path pathXX = Path();
    pathXX.moveTo(cos(toDeg(90 - perDeg)) * R + offsetPosition,
        -sin(toDeg(90 - perDeg)) * R + offsetPosition);
    for (int i = 0; i < num; i++) {
      pathXX.lineTo(cos(toDeg((90 - perDeg) + i * perDeg)) * R + offsetPosition,
          -sin(toDeg((90 - perDeg) + i * perDeg)) * R + offsetPosition);
      if (num > 3)
        pathXX.lineTo(cos(toDeg((90 - perDeg + perDeg / 2) + i * perDeg)) * r + offsetPosition,
            -sin(toDeg((90 - perDeg + perDeg / 2) + i * perDeg)) * r + offsetPosition);
    }
    pathXX.lineTo(cos(toDeg(90 - perDeg)) * R + offsetPosition,
        -sin(toDeg(90 - perDeg)) * R + offsetPosition);
    return pathXX;
  }

  //计算deg
  double toDeg(double degNum) {
    return degNum / 180 * pi;
  }
}

//-----------随机颜色-------------------
Color randomRGB() {
  Random random = new Random();
  int r = 30 + random.nextInt(200);
  int g = 30 + random.nextInt(200);
  int b = 30 + random.nextInt(200);
  return Color.fromARGB(255, r, g, b);
}
