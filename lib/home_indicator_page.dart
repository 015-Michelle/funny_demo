import 'package:flutter/material.dart';
import 'package:myproject/card_data.dart';

class HomeIndicatorPage extends StatefulWidget {
  const HomeIndicatorPage({Key? key}) : super(key: key);

  @override
  _HomeIndicatorPageState createState() => _HomeIndicatorPageState();
}

class _HomeIndicatorPageState extends State<HomeIndicatorPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          PageView.builder(
            onPageChanged: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return Image.asset(cardDataList[index].asset);
            },
            itemCount: cardDataList.length,
          ),
          if (_selectedIndex == 3)
            Positioned(
              right: 10,
              top: 80,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.backspace_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 50),
                  width: _selectedIndex == 0 ? 40 : 20,
                  height: 20,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.deepOrange,
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  width: _selectedIndex == 1 ? 40 : 20,
                  height: 20,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.deepOrange,
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  width: _selectedIndex == 2 ? 40 : 20,
                  height: 20,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.deepOrange,
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  width: _selectedIndex == 3 ? 40 : 20,
                  height: 20,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.deepOrange,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
