import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject/animate_nstar.dart';

import 'ball_run_view_page.dart';
import 'class_ball.dart';

class BallsRunPage extends StatefulWidget {
  const BallsRunPage({Key? key}) : super(key: key);
  @override
  _BallsRunPageState createState() => _BallsRunPageState();
}

class _BallsRunPageState extends State<BallsRunPage> with SingleTickerProviderStateMixin {
  late AnimationController _controllerBall;
  Rect canvasRect = Rect.fromLTRB(0, 0, 200, 200);
  List<Ball> ballList = [];
  late Ball bigBall;
  @override
  void initState() {
    super.initState();
    bigBall = Ball(x: 0, y: 240, ballColor: randomRGB(), r: 100, aX: 0.05, aY: 0.1, vX: 3, vY: -3);
    ballList.add(bigBall);
    print("balllist---->${ballList[0]}");
    _controllerBall =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 2000000));
    _controllerBall.addListener(() {
      setState(() {
        for (int i = 0; i < ballList.length; i++) {
          var currentBall = ballList[i];
          currentBall.x += currentBall.vX;
          currentBall.y += currentBall.vY;
          currentBall.vX += currentBall.aX;
          currentBall.vY += currentBall.aY;
          if (currentBall.y > canvasRect.bottom) {
            var childBall = Ball().copyBall(currentBall);
            // childBall.r = currentBall.r / 2;
            // childBall.vX = -currentBall.vX;
            // childBall.vY = -currentBall.vY;
            // ballList.add(childBall);
            // currentBall.r /= 2;
            // currentBall.y = secondRect.bottom;
            // currentBall.vY = -currentBall.vY;
            // currentBall.ballColor = randomRGB();
          }
          // if (currentBall.y < secondRect.top) {
          //   currentBall.y = secondRect.bottom;
          //   currentBall.vY = -currentBall.vY;
          //   currentBall.ballColor = randomRGB();
          // }
          // if (currentBall.x < secondRect.right) {
          //   currentBall.x = secondRect.right;
          //   currentBall.vX = -currentBall.vX;
          //   currentBall.ballColor = randomRGB();
          // }
          // if (currentBall.x > secondRect.left) {
          //   var childBall = Ball().copyBall(currentBall);
          //   childBall.r = currentBall.r / 2;
          //   childBall.vX = -currentBall.vX;
          //   childBall.vX = -currentBall.vX;
          //   ballList.add(childBall);
          //   currentBall.r /= 2;
          //   currentBall.x = secondRect.left;
          //   currentBall.vX = -currentBall.vX;
          //   currentBall.ballColor = randomRGB();
          // }
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
        painter: BallRunView(bigBall, canvasRect),
      ),
    );
  }

  @override
  void dispose() {
    _controllerBall.dispose();
    super.dispose();
  }
}
