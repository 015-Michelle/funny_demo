import 'dart:math';

import 'package:flutter/material.dart';

import '../digits.dart';

typedef DrawFunction = void Function(Canvas canvas);

class CustomPaintePage extends CustomPainter {
  Rect canvasRect;
  DrawFunction drawFunction;
  CustomPaintePage(
    this.canvasRect,
    this.drawFunction,
  );
  @override
  void paint(Canvas canvas, Size size) {
    Paint paintCanvas = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..color = Colors.black26;
    // Paint paintBall = Paint()
    //   ..style = PaintingStyle.fill
    //   ..strokeWidth = 1
    //   ..color = ball.ballColor;
    canvas.translate(0, 0); //canvas的位置偏移
    canvas.drawRect(canvasRect,
        paintCanvas); //canvas.drawRect(Rect.fromLTWH(-100, -100, 200, 200), paintCanvas);
    // canvas.drawRect(Rect.fromLTRB(0, 0, 20, 40), paintCanvas);
    //canvas.drawCircle(Offset(ball.x, ball.y), ball.r, paintBall);
    drawFunction(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

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
Path drawNStar(int num, double R, double r, int offsetPosition) {
  double perDeg = 360 / num;
  Path pathXX = Path();
  pathXX.moveTo(
      cos(toDeg(90 - perDeg)) * R + offsetPosition, -sin(toDeg(90 - perDeg)) * R + offsetPosition);
  for (int i = 0; i < num; i++) {
    pathXX.lineTo(cos(toDeg((90 - perDeg) + i * perDeg)) * R + offsetPosition,
        -sin(toDeg((90 - perDeg) + i * perDeg)) * R + offsetPosition);
    if (num > 3)
      pathXX.lineTo(cos(toDeg((90 - perDeg + perDeg / 2) + i * perDeg)) * r + offsetPosition,
          -sin(toDeg((90 - perDeg + perDeg / 2) + i * perDeg)) * r + offsetPosition);
  }
  pathXX.lineTo(
      cos(toDeg(90 - perDeg)) * R + offsetPosition, -sin(toDeg(90 - perDeg)) * R + offsetPosition);
  return pathXX;
}

//计算deg
double toDeg(double degNum) {
  return degNum / 180 * pi;
}

//-----------随机颜色-------------------
Color randomRGB() {
  Random random = new Random();
  int r = 30 + random.nextInt(200);
  int g = 30 + random.nextInt(200);
  int b = 30 + random.nextInt(200);
  return Color.fromARGB(255, r, g, b);
}

//数字时钟
void NumClock(int num, Canvas canvas, double R, double r, int offsetPosition, Paint paint) {
  if (num > 10) {
    return;
  }
  for (int i = 0; i < digit[num].length; i++) {
    for (int j = 0; j < digit[num][j].length; j++) {
      if (digit[i][j] == 1) {
        canvas.drawPath(drawNStar(num, R, r, offsetPosition), paint);
      }
    }
  }
}
