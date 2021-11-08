import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myproject/my_demo/todo_list.dart';

void main() {
  Widget mountApp() {
    return MaterialApp(
      home: TodoList(),
    );
  }

  testWidgets('add and remove a todo', (WidgetTester tester) async {
    //build the widget
    await tester.pumpWidget(mountApp());
    //往输入框中输入hi
    await tester.enterText(find.byType(TextField), 'hi');
    //点击button来触发事件
    await tester.tap(find.byType(FloatingActionButton));
    //让widget重绘
    await tester.pump();
    //检测text是否添加到List中
    expect(find.text('hi'), findsOneWidget);

    //测试滑动
    await tester.drag(find.byType(Dismissible), Offset(500.0, 0.0));
    //页面会一直刷新，直到最后一帧绘制完成
    await tester.pumpAndSettle();
    //验证页面中是否还有hi
    expect(find.text('hi'), findsNothing);
  });
}
