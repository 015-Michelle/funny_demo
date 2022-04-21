import 'package:flutter/material.dart';

import 'bottomsheet_page_a.dart';

class BottomsheetWithFluro extends StatelessWidget {
  const BottomsheetWithFluro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("this is a bottomSheet"),
                          Container(
                            height: 350,
                            child: Navigator(
                              initialRoute: '/',
                              onGenerateRoute: (RouteSettings settings) {
                                WidgetBuilder builder = (context) => BPageA();
                                return MaterialPageRoute(builder: builder, settings: settings);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(6)),
                  child: Text("click here,show bottomSheet")),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BPageA())),
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(6)),
                  child: Text("here")),
            )
          ],
        ),
      ),
    );
  }
}
