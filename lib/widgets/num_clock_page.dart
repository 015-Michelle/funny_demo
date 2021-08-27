import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myproject/class_ball.dart';

import 'custom_painte_page.dart';

class NumClockPage extends StatefulWidget {
  const NumClockPage({Key? key}) : super(key: key);

  @override
  _NumClockPageState createState() => _NumClockPageState();
}

class _NumClockPageState extends State<NumClockPage> with SingleTickerProviderStateMixin {
  var num = DateTime.now().hour.toString() +
      ":" +
      DateTime.now().minute.toString() +
      ":" +
      DateTime.now().second.toString();
  late AnimationController _controller;
  late Animation _animation;
  late Path path;
  var _preSecond = DateTime.now().millisecondsSinceEpoch;
  bool isChange = true;
  List<Ball> balls = [];
  List<Offset> opsitions = [];

  @override
  void initState() {
    super.initState();
    // balls.add(Ball(x: 0, y: 0, ballColor: Colors.blue, r: 10, aX: 0, aY: 0.1, vX: 2, vY: -2));
    // balls.add(Ball(x: 10, y: 0, ballColor: Colors.blue, r: 10, aX: 0, aY: 0.1, vX: -2, vY: 0));
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation =
        IntTween(begin: 0, end: 9).animate(CurveTween(curve: Curves.easeInOut).animate(_controller))
          ..addListener(() {
            setState(() {
              if (opsitions.length != 0) {
                opsitions.forEach((element) {
                  balls.add(Ball(
                      x: element.dx * 0.8,
                      y: element.dy * 0.8,
                      ballColor: randomRGB(),
                      r: 1,
                      aX: 0,
                      aY: Random().nextDouble(),
                      vX: Random().nextDouble(),
                      vY: -Random().nextDouble()));
                });
              }
              if (_preSecond != DateTime.now().second.toString()) {
                num = DateTime.now().hour.toString() +
                    ":" +
                    DateTime.now().minute.toString() +
                    ":" +
                    DateTime.now().second.toString();
                isChange = false;
                if (DateTime.now().millisecondsSinceEpoch - _preSecond > 2000) {
                  balls.clear();
                }
              }

              for (int i = 0; i < balls.length; i++) {
                Ball ball = balls[i];
                ball.x += ball.vX;
                ball.y += ball.vY;
                ball.vX += ball.aX;
                ball.vY += ball.aY;
                ball.r = 10;
              }
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _controller.forward();
            }
          });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("数字时钟"),
      ),
      body: CustomPaint(
        painter: CustomPaintePage(Rect.zero, (Canvas canvas) {
          Paint paint = Paint()
            ..style = PaintingStyle.fill
            ..strokeWidth = 1
            ..color = Colors.blue;
          //print("date---->$num");
          List numsStr = num.replaceAll(" ", "").split("");
          List nums = [];
          numsStr.forEach((element) {
            if (element == ":") element = 10;
            nums.add(element is int ? element : int.parse(element));
          });
          int length = nums.length;
          canvas.translate(MediaQuery.of(context).size.width / length / 2, 0);
          for (int i = 0; i < length; i++) {
            path = drawNStar(5, 10, 5, Offset(MediaQuery.of(context).size.width / length * i, 0));
            opsitions = NumClock(nums[i], canvas, 10, 5,
                Offset(MediaQuery.of(context).size.width / length * i, 0), paint, path);
            canvas.translate(MediaQuery.of(context).size.width / length / 2, 0);
          }

          Paint paintBall = Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1
            ..color = Colors.green;
          balls.forEach((ball) {
            canvas.drawCircle(Offset(ball.x, ball.y), ball.r, paintBall);
          });
        }),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
