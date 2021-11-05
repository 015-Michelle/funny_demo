import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myproject/widgets/my_widget.dart';

void main() {
  Widget mountApp() {
    return MaterialApp(
      home: MyWidget(title: 'T', message: 'M'),
    );
  }

  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    //加载widget
    await tester.pumpWidget(mountApp());

    final titleFinder = find.text('T');
    final messageFinder = find.text('M');

    //验证页面中是否含有上述的两个text
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}
