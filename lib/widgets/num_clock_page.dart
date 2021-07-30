import 'package:flutter/material.dart';

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
  String _preSecond = DateTime.now().second.toString();
  bool isChange = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation =
        IntTween(begin: 0, end: 9).animate(CurveTween(curve: Curves.easeInOut).animate(_controller))
          ..addListener(() {
            setState(() {
              if (_preSecond != DateTime.now().second.toString()) {
                num = DateTime.now().hour.toString() +
                    ":" +
                    DateTime.now().minute.toString() +
                    ":" +
                    DateTime.now().second.toString();
                isChange = false;
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
            path = i < 6
                ? drawNStar(5, 10, 5, Offset(MediaQuery.of(context).size.width / length * i, 0))
                : drawNStar(5, 10, 10, Offset(MediaQuery.of(context).size.width / length * i, 0));
            NumClock(nums[i], canvas, 10, 5,
                Offset(MediaQuery.of(context).size.width / length * i, 0), paint, path);
            canvas.translate(MediaQuery.of(context).size.width / length / 2, 0);
          }
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
