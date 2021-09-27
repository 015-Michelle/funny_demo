import 'package:flutter/material.dart';

class FABPage extends StatefulWidget {
  const FABPage({Key? key}) : super(key: key);

  @override
  _FABPageState createState() => _FABPageState();
}

class _FABPageState extends State<FABPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("floatingActionButton"),
      ),
      body: Center(
        child: FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          tooltip: 'floatingActionButton',
          heroTag: 'floating',
          elevation: 10,
          highlightElevation: 20,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                width: 2,
                color: Colors.deepOrange,
              )),
        ),
      ),
    );
  }
}
