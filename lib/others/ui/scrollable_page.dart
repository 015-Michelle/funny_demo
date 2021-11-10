import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollableDemo extends StatelessWidget {
  final data = List.generate(32, (i) => Color(0xFF6600FF - 2 * i));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Scrollable(
        axisDirection: AxisDirection.down,
        physics: BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.start,
        viewportBuilder: (ctx, position) => Viewport(
          cacheExtent: 200,
          cacheExtentStyle: CacheExtentStyle.pixel,
          offset: position,
          slivers: <Widget>[_buildSliverList()],
        ),
      ),
    );
  }

  Widget _buildSliverList() => SliverList(
        delegate: SliverChildBuilderDelegate(
            (_, int index) => Container(
                  margin: EdgeInsets.only(top: 1),
                  alignment: Alignment.center,
                  width: 100,
                  height: 60,
                  color: data[index],
                  child: Text(
                    colorString(data[index]),
                    style: TextStyle(color: Colors.white, shadows: [
                      Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
                    ]),
                  ),
                ),
            childCount: data.length),
      );

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
