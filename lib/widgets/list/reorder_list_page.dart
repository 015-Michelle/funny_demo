import 'package:flutter/material.dart';

class ReOrderListPage extends StatefulWidget {
  const ReOrderListPage({Key? key}) : super(key: key);

  @override
  _ReOrderListPageState createState() => _ReOrderListPageState();
}

class _ReOrderListPageState extends State<ReOrderListPage> {
  final List<int> _items = List<int>.generate(50, (int index) => index);
  final Color oddItemColor = Colors.green.withOpacity(0.05);
  final Color evenItemColor = Colors.blue.withOpacity(0.15);
  late List<bool> _checkboxSelected = []; //维护复选框状态
  List<int> _indexList = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 50; i++) _checkboxSelected.add(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ReOrderableListView'),
      ),
      body: ReorderableListView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        header: GestureDetector(
          onTap: () {},
          child: Text('选完了'),
        ),
        children: <Widget>[
          for (int index = 0; index < _items.length; index++)
            ReorderableDragStartListener(
              key: Key('$index'),
              index: index,
              child: CheckboxListTile(
                title: Text('Item ${_items[index]}'),
                value: _indexList.contains(index),
                onChanged: (bool? value) {
                  setState(() {
                    //_checkboxSelected[index] = !_checkboxSelected[index];
                    if (_indexList.contains(_items[index])) _indexList.removeAt(_items[index]);
                    _indexList.add(_items[index]);
                    debugPrint('index==${_indexList}');
                  });
                },
                selected: _indexList.contains(_items[index]),
                controlAffinity: ListTileControlAffinity.leading,
                secondary: const Icon(Icons.list),
              ),
            ),
          // ListTile(
          //   leading: Container(
          //       child: Checkbox(
          //     value: _checkboxSelected[index],
          //     activeColor: Colors.red,
          //     onChanged: (value) {
          //       debugPrint('你选择了===$index');
          //       setState(() {
          //         _checkboxSelected[index] = !_checkboxSelected[index];
          //       });
          //     },
          //   )),
          //   isThreeLine: true,
          //   subtitle: Text('haha'),
          //   trailing: Icon(Icons.list),
          //   enabled: true,
          //   enableFeedback: true,
          //   key: Key('$index'),
          //   tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
          //   title: Text('Item ${_items[index]}'),
          // ),
          // Container(
          //   key: Key('$index'),
          //   color: _items[index].isOdd ? oddItemColor : evenItemColor,
          //   child: Row(
          //     children: [
          //       Container(
          //         width: 64,
          //         height: 64,
          //         padding: const EdgeInsets.all(8),
          //         child: ReorderableDragStartListener(
          //           index: index,
          //           child: Card(
          //             color: Colors.blue,
          //             elevation: 2,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final int item = _items.removeAt(oldIndex);
            _items.insert(newIndex, item);
          });
        },
        buildDefaultDragHandles: true,
      ),
    );
  }
}
