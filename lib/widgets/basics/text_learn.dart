import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject/router/my_router.dart';
import 'package:myproject/router/routers.dart';

class TextLearn extends StatefulWidget {
  const TextLearn({Key? key}) : super(key: key);

  @override
  _TextLearnState createState() => _TextLearnState();
}

class _TextLearnState extends State<TextLearn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("了解文本")),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('原本样式'),
          Text('当字数套多，屏幕显示宽度不够时，多余的文字用省略号表示', overflow: TextOverflow.ellipsis),
          Text('给文本一个背景色', style: TextStyle(backgroundColor: Colors.teal)),
          Text('给文本一个前景色', style: TextStyle(foreground: Paint()..color = Colors.orange)),
          Text('直接给文本颜色', style: TextStyle(color: Colors.orange)),
          Text(
            '双下划线',
            style: TextStyle(
              decorationStyle: TextDecorationStyle.double,
              decoration: TextDecoration.underline,
            ),
          ),
          FloatingActionButton(
            onPressed: () => MyRouter.to(context, Routes.fab_page),
            tooltip: 'floatingActionButton',
            foregroundColor: Colors.green,
            backgroundColor: Colors.deepOrange,
            heroTag: 'floating',
          ),
        ],
      ),
    );
  }
}
