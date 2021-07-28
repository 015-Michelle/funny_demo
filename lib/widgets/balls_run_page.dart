import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../class_ball.dart';
import 'custom_painte_page.dart';

class BallsRunPage extends StatefulWidget {
  const BallsRunPage({Key? key}) : super(key: key);
  @override
  _BallsRunPageState createState() => _BallsRunPageState();
}

class _BallsRunPageState extends State<BallsRunPage> with SingleTickerProviderStateMixin {
  late AnimationController _controllerBall;
  Rect canvasRect = Rect.fromLTRB(0, 0, 300, 300);
  List<Ball> ballList = [];
  late Ball bigBall;
  @override
  void initState() {
    super.initState();
    bigBall = Ball(x: 0, y: 0, ballColor: randomRGB(), r: 100, aX: 0, aY: 0.1, vX: 3, vY: -3);
    ballList.add(bigBall);
    print("balllist---->${ballList[0]}");
    _controllerBall =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 2000000));
    _controllerBall.addListener(() {
      setState(() {
        for (int i = 0; i < ballList.length; i++) {
          var ball = ballList[i];
          ball.x += ball.vX;
          ball.y += ball.vY;
          ball.vX += ball.aX;
          ball.vY += ball.aY;
          if (ball.r < 1) {
            ballList.remove(ball);
          }
          if (ball.y > canvasRect.bottom - ball.r) {
            ball.y = canvasRect.bottom - ball.r;
            ball.vY = -ball.vY;
            ball.ballColor = randomRGB();
            var newBall = Ball(
                x: ball.x,
                y: ball.y,
                ballColor: randomRGB(),
                aX: ball.aX,
                aY: ball.aY,
                vX: -ball.vX,
                vY: ball.vY);
            newBall.r = ball.r / 2;
            ball.r /= 2;
            ballList.add(newBall);
          }
          if (ball.y < canvasRect.top + ball.r) {
            ball.y = canvasRect.top + ball.r;
            ball.vY = -ball.vY;
            ball.ballColor = randomRGB();
          }
          if (ball.x > canvasRect.right - ball.r) {
            ball.x = canvasRect.right - ball.r;
            ball.vX = -ball.vX;
            ball.ballColor = randomRGB();
            var newBall = Ball(
                x: ball.x,
                y: ball.y,
                ballColor: randomRGB(),
                aX: ball.aX,
                aY: ball.aY,
                vX: ball.vX,
                vY: -ball.vY);
            newBall.r = ball.r / 2;
            ball.r /= 2;
            ballList.add(newBall);
          }
          if (ball.x < canvasRect.left + ball.r) {
            ball.x = canvasRect.left + ball.r;
            ball.vX = -ball.vX;
            ball.ballColor = randomRGB();
          }
        }
      });
    });
    _controllerBall.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controllerBall.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controllerBall.forward();
      }
    });
    _controllerBall.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("balls"),
      ),
      body: CustomPaint(
        painter: CustomPaintePage(canvasRect, (canvas) {
          ballList.forEach((ball) {
            Paint paintBall = Paint()
              ..style = PaintingStyle.fill
              ..strokeWidth = 1
              ..color = ball.ballColor;
            paintBall.color = ball.ballColor;
            canvas.drawCircle(Offset(ball.x, ball.y), ball.r, paintBall);
          });
        }),
      ),
    );
  }

  @override
  void dispose() {
    _controllerBall.dispose();
    super.dispose();
  }
}
