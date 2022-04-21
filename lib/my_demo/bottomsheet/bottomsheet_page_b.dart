import 'package:flutter/material.dart';

class BPageB extends StatelessWidget {
  const BPageB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        color: Colors.red,
        child: Text("<"),
      ),
    );
  }
}
