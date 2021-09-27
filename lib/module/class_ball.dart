import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ball {
  //坐标
  double x;
  double y;
  //速度
  double vX;
  double vY;
  //加速度
  double aX;
  double aY;
  //颜色
  Color ballColor;
  //半径
  double r;

  Ball(
      {this.x = 0,
      this.y = 0,
      this.aX = 0,
      this.aY = 0,
      this.ballColor = Colors.blue,
      this.r = 10,
      this.vX = 0,
      this.vY = 0});

  copyBall(Ball ball) {
    this.ballColor = ball.ballColor;
    this.x = ball.x;
    this.y = ball.y;
    this.aY = ball.aY;
    this.aX = ball.aX;
    this.vY = ball.vY;
    this.vX = ball.vX;
    this.r = ball.r;
  }
}
