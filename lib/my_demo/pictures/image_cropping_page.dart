import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageCroppingPage extends StatefulWidget {
  const ImageCroppingPage({Key? key}) : super(key: key);

  @override
  _ImageCroppingPageState createState() => _ImageCroppingPageState();
}

class _ImageCroppingPageState extends State<ImageCroppingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(title: Text('Picture'), centerTitle: true),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Text('you can hold the picture and drag to sort'),
                        Icon(Icons.add),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
