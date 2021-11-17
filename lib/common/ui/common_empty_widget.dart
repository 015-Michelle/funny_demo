import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonEmptyWidget extends StatelessWidget {
  const CommonEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home_outlined,
              color: Colors.grey,
              size: 36,
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              'Empty Page!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
