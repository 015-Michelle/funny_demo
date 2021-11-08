import 'package:flutter/material.dart';

class InputScrollPage extends StatefulWidget {
  const InputScrollPage({Key? key}) : super(key: key);

  @override
  _InputScrollPageState createState() => _InputScrollPageState();
}

class _InputScrollPageState extends State<InputScrollPage> {
  ScrollController scrollController = ScrollController();
  late FocusNode _focusNode;
  bool isKeyboardActivated = false;
  bool isScrollable = false;
  GlobalKey _txtKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scrollbar'),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 2,
          child: Column(
            children: [
              Container(color: Colors.deepOrange, height: 120),
              Container(
                color: Colors.amber,
                height: 150,
                child: TextField(
                  key: _txtKey,
                  scrollPadding: EdgeInsets.all(0),
                  focusNode: _focusNode,
                  onTap: () {
                    // scrollController.animateTo(
                    //   120,
                    //   duration: const Duration(milliseconds: 300),
                    //   curve: Curves.ease,
                    // );
                    Scrollable.ensureVisible(
                      _txtKey.currentContext ?? context,
                      duration: Duration(milliseconds: 300),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
