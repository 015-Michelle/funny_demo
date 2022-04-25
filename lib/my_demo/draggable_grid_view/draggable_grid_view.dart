import 'package:flutter/material.dart';
import 'package:myproject/my_demo/draggable_grid_view/reorderable_grid_view.dart';

class DraggableGridView extends StatefulWidget {
  const DraggableGridView({Key? key}) : super(key: key);

  @override
  State<DraggableGridView> createState() => _DraggableGridViewState();
}

class _DraggableGridViewState extends State<DraggableGridView> {
  List<Widget> datas = [Text("1"), Text("2"), Text("3"), Text("4"), Text("5")];
  List<int> size = [160, 100, 160, 80, 80];
  double width = 0;
  int i = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    i = 0;
    return Scaffold(
      appBar: AppBar(title: Text("draggable grid view")),
      // body: GridView.builder(
      //   itemCount: datas.length,
      //   scrollDirection: Axis.vertical,
      //   itemBuilder: (BuildContext context, int index) {
      //     return _buildItem(index);
      //   },
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      // ),
      body: ReorderableGridView(
        children: datas.map((e) {
          i++;
          return Stack(
            key: ValueKey(e),
            alignment: Alignment.topRight,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: Colors.red,
                ),
                // width: (width - 76) / 4,
                // height: (width - 76) / 4,
                width: size[i - 1].toDouble(),
                height: size[i - 1].toDouble(),
                child: e,
              ),
            ],
          );
        }).toList(),
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: size[i - 1] > 160 ? 1 : 2,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            var element = datas.removeAt(oldIndex);
            var temp = size.removeAt(oldIndex);
            size.insert(newIndex, temp);
            datas.insert(newIndex, element);
          });
        },
        footer: [
          // if (datas.length < 10)
          //   GestureDetector(
          //     onTap: () {},
          //     child: Container(
          //       key: Key('add'),
          //       alignment: Alignment.center,
          //       decoration:
          //           BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.circular(4)),
          //       child: Container(
          //         child: Text("haha"),
          //         width: 20,
          //         height: 20,
          //       ),
          //     ),
          //   )
        ],
      ),
    );
  }

  Widget _buildItem(int index) {
    return LongPressDraggable(
      data: index,
      child: DragTarget<int>(
        onAccept: (data) {
          setState(() {
            var temp = datas[data];
            datas.remove(data);
            datas.insert(index, temp);
          });
        },
        builder: (context, data, rejects) {
          return Card(
            child: Center(
              child: Text("x==${datas[index]}"),
            ),
          );
        },
      ),
      feedback: SizedBox(
        child: Center(
          child: Icon(Icons.feedback),
        ),
      ),
    );
  }
}
