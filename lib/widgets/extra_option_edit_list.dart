import 'package:flutter/material.dart';

class ExtraOptionsEditList extends StatefulWidget {
  const ExtraOptionsEditList({Key? key}) : super(key: key);

  @override
  _ExtraOptionsEditListState createState() => _ExtraOptionsEditListState();
}

class _ExtraOptionsEditListState extends State<ExtraOptionsEditList> {
  List<Map<String, dynamic>> datas = [
    {
      'name': '1',
      'value': ['value1']
    },
    {
      'name': '2',
      'value': ['value', 'dfjfds', 'fsdjjweew', 'aeryh']
    },
    {
      'name': '3',
      'value': ['value3']
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return Divider(height: 0, thickness: 1, color: Colors.blue);
        },
        itemBuilder: (BuildContext context, int index) {
          return _buildExtraOptionsEdit(datas[index], index);
        },
        itemCount: datas.length,
      ),
    );
  }

  Widget _buildExtraOptionsEdit(Map<String, dynamic> data, int index) {
    return Column(
      children: [
        Stack(
          children: [
            Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              child: Container(
                alignment: Alignment.center,
                color: Colors.green,
                width: 56,
                // This child will fill full height, replace it with your leading widget
                child: Center(
                  child: Image.asset(
                    'assets/ic_menu_edit.png',
                    height: 16,
                    width: 16,
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  // Here your column with texts
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(data['name']),
                      Container(
                        child: Wrap(
                          spacing: 6.0,
                          runSpacing: 6.0,
                          children: listWidget(data),
                        ),
                      )
                    ],
                  ),
                ),
                //SizedBox(width: 56),
              ],
            )
          ],
        ),
      ],
    );
  }

  List<Widget> listWidget(Map<String, dynamic> data) {
    List<Widget> optionWidgetList = [];
    for (int i = 0; i < data['value'].length; i++) {
      optionWidgetList.add(Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: Colors.black26),
        ),
        //width: 90,
        child: Text(
          data['value'][i], //todo
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ));
    }
    return optionWidgetList;
  }
}
