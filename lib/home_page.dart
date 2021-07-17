import 'package:card_flip/card_flip_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("项目列表"),
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CardFlipPage()));
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  "锁屏换图",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
