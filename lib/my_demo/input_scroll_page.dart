import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  //保存进度百分比
  String _progress = '0%';
  GlobalKey columnKey = GlobalKey();
  late double scrollHeight;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    scrollHeight = 800;
    debugPrint('here1==>${scrollHeight}');
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      RenderBox renderBox = _txtKey.currentContext!.findRenderObject() as RenderBox;
      Offset offset = renderBox.localToGlobal(Offset.zero);
      scrollHeight = offset.dy / 2 + MediaQuery.of(context).size.height;
      debugPrint('here2==>${scrollHeight}');
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('Scrollbar'),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          double progress = notification.metrics.pixels / notification.metrics.maxScrollExtent;
          notification.metrics.copyWith(
            maxScrollExtent: 120,
            minScrollExtent: 120,
            viewportDimension: 120,
          );
          setState(() {
            isScrollable = progress < 0.3;
            _progress = '${progress * 100.toInt()} %';
          });
          return true;
        },
        child: Listener(
          onPointerMove: (movePointEvent) {
            FocusScope.of(context).unfocus();
          },
          child: Scrollable(
            controller: scrollController,
            physics: ClampingScrollPhysics(),
            viewportBuilder: (ctx, position) => Viewport(
              cacheExtent: 200,
              cacheExtentStyle: CacheExtentStyle.pixel,
              offset: position,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: scrollHeight,
                    child: Column(
                      key: columnKey,
                      children: [
                        Container(color: Colors.deepOrange, height: 120),
                        Container(
                          color: Colors.amber,
                          height: 150,
                          child: TextField(
                            key: _txtKey,
                            scrollPadding: EdgeInsets.all(0),
                            focusNode: _focusNode,
                            maxLines: 3,
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
                        Container(color: Colors.deepOrange, height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // viewportBuilder: (BuildContext context, ViewportOffset position) {
            //   return SizedBox(
            //     height: MediaQuery.of(context).size.height * 2,
            //     child: Column(
            //       key: columnKey,
            //       children: [
            //         Container(color: Colors.deepOrange, height: 120),
            //         Container(
            //           color: Colors.amber,
            //           height: 150,
            //           child: TextField(
            //             key: _txtKey,
            //             scrollPadding: EdgeInsets.all(0),
            //             focusNode: _focusNode,
            //             onTap: () {
            //               // scrollController.animateTo(
            //               //   120,
            //               //   duration: const Duration(milliseconds: 300),
            //               //   curve: Curves.ease,
            //               // );
            //               Scrollable.ensureVisible(
            //                 _txtKey.currentContext ?? context,
            //                 duration: Duration(milliseconds: 300),
            //               );
            //             },
            //           ),
            //         ),
            //       ],
            //     ),
            //   );
            // },
          ),
        ),
      ),
      bottomNavigationBar: CircleAvatar(
        radius: 30.0,
        child: Text(_progress),
        backgroundColor: Colors.black54,
      ),
      // body: Scrollbar(
      //   //进度条
      //   //监听滚动通知
      //   child: NotificationListener<ScrollNotification>(
      //     onNotification: (ScrollNotification notification) {
      //       double progress = notification.metrics.pixels / notification.metrics.maxScrollExtent;
      //       setState(() {
      //         _progress = '${progress * 100.toInt()} %';
      //         isScrollable = progress * 100.toInt() < 50;
      //       });
      //       print('bottomEdge:${notification.metrics.extentAfter == 0}');
      //       return true;
      //     },
      //     child: Stack(
      //       alignment: Alignment.center,
      //       children: [
      //         ListView.builder(
      //           itemBuilder: (context, index) {
      //             return ListTile(title: Text('$index'));
      //           },
      //           itemCount: 100,
      //           itemExtent: 50.0,
      //         ),
      //         CircleAvatar(
      //           radius: 30.0,
      //           child: Text(_progress),
      //           backgroundColor: Colors.black54,
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
