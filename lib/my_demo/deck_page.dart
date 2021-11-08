import 'package:deck/deck.dart';
import 'package:flutter/material.dart';

class DeckPage extends StatelessWidget {
  const DeckPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Deck.registerEventHandler(EventHandler((event) {
      switch (event.name) {
        case "url":
      }
    }));

    return DeckView({
      "url": "https://cdnimg.doutian.me/20210321/86881616295843415?imageMogr2/auto-orient",
      "eventType": "url",
      "eventConf": "http:///www.baidu.com"
    });
  }
}
