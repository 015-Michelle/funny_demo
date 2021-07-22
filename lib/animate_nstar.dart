import 'dart:math';

import 'package:flutter/material.dart';

class AnimateNStar extends StatefulWidget {
  const AnimateNStar({Key? key}) : super(key: key);

  @override
  _AnimateNStarState createState() => _AnimateNStarState();
}

class _AnimateNStarState extends State<AnimateNStar> with SingleTickerProviderStateMixin {
  late Color starColor = Colors.blue;
  late AnimationController _animationController;
  late Animation<double> _animationScale;
  double _R = 50;
  late Animation<int> _animationSun;
  int num = 5;
  late Animation<Color?> _animationColor;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _animationScale = Tween<double>(begin: 20, end: 50)
        .animate(CurveTween(curve: Curves.bounceInOut).animate(_animationController))
          ..addListener(() {
            setState(() {
              _R = _animationScale.value;
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _animationController.forward();
            }
          });
    _animationSun = IntTween(begin: 4, end: 50).animate(_animationController)
      ..addListener(() {
        setState(() {
          num = _animationSun.value;
        });
      });
    _animationColor =
        ColorTween(begin: Colors.yellow, end: Colors.red).animate(_animationController)
          ..addListener(() {
            setState(() {
              starColor = _animationColor.value!;
            });
          });

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的棋盘"),
      ),
      body: GestureDetector(
        child:
            // CustomPaint(
            //   size: MediaQuery.of(context).size,
            //   painter: DrawChessBoradPage(context, starColor, _R),
            // ),
            CustomPaint(
          size: MediaQuery.of(context).size,
          painter: DrawChessBoradPage(context, starColor, _R, num: num),
        ),
        onTap: () {
          setState(() {
            starColor = randomRGB();
            //_animationController.forward();
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class DrawChessBoradPage extends CustomPainter {
  BuildContext context;
  Color startColor;
  double R;
  int num;

  DrawChessBoradPage(this.context, this.startColor, this.R, {this.num = 5});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paintXY = Paint()
      ..style = PaintingStyle.fill
      ..color = startColor
      ..strokeWidth = 3;
    Path pathXX = drawNStar(num, R, 30, 100);
    canvas.drawPath(pathXX, paintXY);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  //画五角星
  Path drawNStar(int num, double R, double r, int offsetPosition) {
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
