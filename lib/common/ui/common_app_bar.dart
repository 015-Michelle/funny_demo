import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget {
  String title;
  CommonAppBar(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(bottom: false, child: Container()),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black54),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back_ios_rounded),
              ),
              Expanded(child: Text(this.title)),
            ],
          ),
        ),
      ],
    );
  }
}
