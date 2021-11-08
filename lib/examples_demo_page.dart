import 'package:flutter/material.dart';
import 'package:myproject/router/my_router.dart';
import 'package:myproject/router/routers.dart';

class ExamplesDemoPage extends StatefulWidget {
  const ExamplesDemoPage({Key? key}) : super(key: key);

  @override
  _ExamplesDemoPageState createState() => _ExamplesDemoPageState();
}

class _ExamplesDemoPageState extends State<ExamplesDemoPage> {
  @override
  void initState() {
    super.initState();
    MyRouter.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('别人的例子')),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: [
          _buildContentItem(
            title: 'Sliver',
            onTap: () => MyRouter.to(
              context,
              Routes.sliverExample,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentItem({required String title, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.orangeAccent.withOpacity(0.5),
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: Text(title),
      ),
    );
  }
}
