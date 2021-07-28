import 'package:flutter/material.dart';

import 'custom_painte_page.dart';

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
        child: CustomPaint(
          size: MediaQuery.of(context).size,
          painter: CustomPaintePage(Rect.zero, (canvas) {
            Paint paintXY = Paint()
              ..style = PaintingStyle.fill
              ..color = starColor
              ..strokeWidth = 3;
            Path pathXX = drawNStar(num, _R, 30, 100);
            canvas.drawPath(pathXX, paintXY);
          }),
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
