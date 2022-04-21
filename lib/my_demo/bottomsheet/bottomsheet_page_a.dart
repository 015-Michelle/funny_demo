import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject/my_demo/bottomsheet/bottomsheet_page_b.dart';

class BPageA extends StatelessWidget {
  const BPageA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => BPageB())),
      child: Container(
        color: Colors.green,
        child: Text(">"),
      ),
    );
  }
}
