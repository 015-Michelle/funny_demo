import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject/animate_nstar.dart';

import 'class_ball.dart';

class BallRunPage extends StatefulWidget {
  const BallRunPage({Key? key}) : super(key: key);
  @override
  _BallRunPageState createState() => _BallRunPageState();
}

class _BallRunPageState extends State<BallRunPage> with SingleTickerProviderStateMixin {
  late AnimationController _controllerBall;
  late Ball ball;
  Rect canvasRect = Rect.fromLTRB(0, 0, 200, 200);
  @override
  void initState() {
    super.initState();
    ball = Ball(x: 0, y: 0, ballColor: Colors.blue, r: 10, aX: 0, aY: 0.1, vX: 2, vY: -2);
    _controllerBall =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 2000000));
    _controllerBall.addListener(() {
      setState(() {
        updateBallPosition();
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

  void updateBallPosition() {
    ball.x += ball.vX;
    ball.y += ball.vY;
    ball.vX += ball.aX;
    ball.vY += ball.aY;
    ball.r = 10;
    if (ball.y > canvasRect.bottom - ball.r) {
      ball.y = canvasRect.bottom - ball.r;
      ball.vY = -ball.vY;
      ball.ballColor = randomRGB();
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
    }
    if (ball.x < canvasRect.left + ball.r) {
      ball.x = canvasRect.left + ball.r;
      ball.vX = -ball.vX;
      ball.ballColor = randomRGB();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("粒子运动"),
      ),
      body: CustomPaint(
        painter: BallRunView(ball, canvasRect),
      ),
    );
  }

  @override
  void dispose() {
    _controllerBall.dispose();
    super.dispose();
  }
}

class BallRunView extends CustomPainter {
  Ball ball;
  Rect canvasRect;
  BallRunView(
    this.ball,
    this.canvasRect,
  );
  @override
  void paint(Canvas canvas, Size size) {
    Paint paintCanvas = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..color = Colors.black26;
    Paint paintBall = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1
      ..color = ball.ballColor;
    canvas.translate(20, 20); //canvas的位置偏移
    canvas.drawRect(canvasRect,
        paintCanvas); //canvas.drawRect(Rect.fromLTWH(-100, -100, 200, 200), paintCanvas);
    // canvas.drawRect(Rect.fromLTRB(0, 0, 20, 40), paintCanvas);
    canvas.drawCircle(Offset(ball.x, ball.y), ball.r, paintBall);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
