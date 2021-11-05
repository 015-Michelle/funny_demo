import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  FirstPage({Key? key}) : super(key: key);

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        reverse: false,
        scrollDirection: Axis.vertical,
        slivers: [
          _buildSliverAppBar(),
          _buildSliverPersistentHeader(),
          _buildSliverList(),
          //_buildSliverGrid(),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 190,
      pinned: true,
      title: Text('title'),
      leading: ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/error.jpg',
          image: 'https://scpic.chinaz.net/files/pic/pic9/202009/apic27858.jpg',
          fit: BoxFit.cover,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text('FlexibleSpaceBar-center'),
        centerTitle: true,
        stretchModes: [StretchMode.zoomBackground],
        background: FadeInImage.assetNetwork(
          placeholder: 'assets/error.jpg',
          image:
              'http://img.desktx.com/d/file/wallpaper/scenery/20170209/ca186d97701674b996264b2d352894a7.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildSliverPersistentHeader() {
    bool isSelected = false;
    return SliverPersistentHeader(
      pinned: true,
      delegate: HeaderDelegate(
        minHeight: 100,
        maxHeight: 100,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.blue,
          ),
          child: Column(
            children: [
              Text('SliverPersistentHeader停在顶部'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: Text('到顶部'),
                    selected: isSelected,
                    onSelected: (bool isSelected) {
                      //scrollController.jumpTo();
                      isSelected = !isSelected;
                    },
                  ),
                  SizedBox(width: 6),
                  ChoiceChip(label: Text('到中间'), selected: isSelected),
                  SizedBox(width: 6),
                  ChoiceChip(label: Text('到底部'), selected: isSelected),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              key: GlobalKey(debugLabel: '$index'),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.blue.withOpacity(0.5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                '$index',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          );
        },
        childCount: 20,
      ),
    );
  }

  // Widget _buildSliverGrid(){
  //   return SliverGrid(delegate: delegate, gridDelegate: gridDelegate);
  // }

  Widget itemGuide(String text, Widget toPage, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => toPage));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Text(text),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Colors.blue),
        ),
      ),
    );
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double minHeight;
  double maxHeight;

  HeaderDelegate({required this.child, required this.maxHeight, required this.minHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => max(minHeight, maxHeight);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(HeaderDelegate oldDelegate) {
    return minHeight != oldDelegate.minExtent ||
        maxHeight != oldDelegate.maxExtent ||
        child != oldDelegate.child;
  }
}
