import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:myproject/first_page_controller.dart';
import 'package:myproject/my_demo_page.dart';
import 'package:myproject/test_demo_page.dart';

import 'examples_demo_page.dart';

class FirstPage extends StatelessWidget {
  FirstPage({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();
  final FirstPageController firstPageController = Get.put(FirstPageController());

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
          _buildSliverToBoxAdapter(),
          //_buildSliverList(),
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
    return GetBuilder<FirstPageController>(
      builder: (_) => SliverPersistentHeader(
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
                boxShadow: [BoxShadow(color: Colors.black12)]),
            child: Column(
              children: [
                Text('SliverPersistentHeader可以停在顶部的'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilterChip(
                      selectedColor: Colors.orange.withAlpha(55),
                      selectedShadowColor: Colors.blue,
                      shadowColor: Colors.orangeAccent,
                      pressElevation: 5,
                      elevation: 3,
                      avatar: CircleAvatar(child: Text('A')),
                      label: Text(firstPageController.getHomeData()[0]),
                      selected: firstPageController.compareIndex(0),
                      onSelected: (bool value) {
                        scrollController.animateTo(scrollController.position.minScrollExtent,
                            duration: Duration(milliseconds: 400), curve: Curves.ease);
                        firstPageController.changeSelectedIndex(0);
                      },
                    ),
                    SizedBox(width: 6),
                    FilterChip(
                      selectedColor: Colors.orange.withAlpha(55),
                      selectedShadowColor: Colors.blue,
                      shadowColor: Colors.orangeAccent,
                      pressElevation: 5,
                      elevation: 3,
                      avatar: CircleAvatar(child: Text('B')),
                      label: Text(firstPageController.getHomeData()[1]),
                      selected: firstPageController.compareIndex(1),
                      onSelected: (bool value) {
                        scrollController.animateTo(scrollController.position.maxScrollExtent / 2,
                            duration: Duration(milliseconds: 400), curve: Curves.ease);
                        firstPageController.changeSelectedIndex(1);
                      },
                    ),
                    SizedBox(width: 6),
                    FilterChip(
                      selectedColor: Colors.orange.withAlpha(55),
                      selectedShadowColor: Colors.blue,
                      shadowColor: Colors.orangeAccent,
                      pressElevation: 5,
                      elevation: 3,
                      avatar: CircleAvatar(child: Text('C')),
                      label: Text(firstPageController.getHomeData()[2]),
                      selected: firstPageController.compareIndex(2),
                      onSelected: (bool value) {
                        scrollController.animateTo(scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 500), curve: Curves.ease);
                        firstPageController.changeSelectedIndex(2);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 可以容纳一个普通组件，并将其转化成Sliver家族组件的适配器
  Widget _buildSliverToBoxAdapter() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          buildContentItem(
            title: firstPageController.getHomeData()[0],
            onTap: () => Get.to(
              () => MyDemoPage(),
            ),
          ),
          buildContentItem(
            title: firstPageController.getHomeData()[1],
            onTap: () => Get.to(
              () => ExamplesDemoPage(),
            ),
          ),
          buildContentItem(
            title: firstPageController.getHomeData()[2],
            onTap: () => Get.to(
              () => TestDemoPage(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return buildContentItem(title: firstPageController.getHomeData()[index]);
        },
        childCount: firstPageController.getHomeData().length,
      ),
    );
  }

  Widget buildContentItem({required String title, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        height: 200,
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
          title,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
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
