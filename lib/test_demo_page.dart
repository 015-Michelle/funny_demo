import 'package:flutter/material.dart';
import 'package:myproject/common/ui/common_empty_widget.dart';

class TestDemoPage extends StatefulWidget {
  const TestDemoPage({Key? key}) : super(key: key);

  @override
  _TestDemoPageState createState() => _TestDemoPageState();
}

class _TestDemoPageState extends State<TestDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('做一个测试吧')),
      body: CommonEmptyWidget(),
    );
  }
}
