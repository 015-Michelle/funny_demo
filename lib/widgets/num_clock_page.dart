import 'package:flutter/material.dart';

import 'custom_painte_page.dart';

class NumClockPage extends StatefulWidget {
  const NumClockPage({Key? key}) : super(key: key);

  @override
  _NumClockPageState createState() => _NumClockPageState();
}

class _NumClockPageState extends State<NumClockPage> {
  var num = DateTime.now().hour.toString() +
      ":" +
      DateTime.now().minute.toString() +
      ":" +
      DateTime.now().second.toString();

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
          List numsStr = num.replaceAll(" ", "").split("");
          List nums = [];
          numsStr.forEach((element) {
            if (element == ":") element = 10;
            nums.add(element is int ? element : int.parse(element));
          });
          int length = nums.length;
          for (int i = 0; i < length; i++) {
            NumClock(nums[i], canvas, 10, 5,
                Offset(MediaQuery.of(context).size.width / length * i, 0), paint);
            canvas.translate(MediaQuery.of(context).size.width / length / 2, 0);
          }
        }),
      ),
    );
  }
}
