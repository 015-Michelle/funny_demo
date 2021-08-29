import 'package:flutter/material.dart';

class HeroTest extends StatefulWidget {
  const HeroTest({Key? key}) : super(key: key);

  @override
  _HeroTestState createState() => _HeroTestState();
}

class _HeroTestState extends State<HeroTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('小图'),
      ),
      body: GestureDetector(
        child: Hero(
          tag: 'tag',
          child: ClipOval(
            child: Image.asset(
              'assets/ic_hero.jpg',
              width: 50,
            ),
          ),
          transitionOnUserGestures: true,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (BuildContext context) => HeroPage())),
      ),
    );
  }
}

class HeroPage extends StatefulWidget {
  const HeroPage({Key? key}) : super(key: key);

  @override
  _HeroPageState createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('大图'),
      // ),
      body: GestureDetector(
        child: Hero(
          tag: 'tag',
          child: Image.asset(
            'assets/ic_hero.jpg',
            fit: BoxFit.fill,
          ),
        ),
        onTap: () => Navigator.of(context).pop(),
      ),
    );
  }
}
