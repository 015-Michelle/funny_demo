import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController controller = TextEditingController();
  final List<String> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('flutter demo for test')),
      body: Column(
        children: [
          TextField(
            controller: controller,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key('$index'),
                  child: ListTile(
                    title: Text(todos[index]),
                    onLongPress: () {
                      todos.removeAt(index);
                      setState(() {});
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (controller.text.isNotEmpty) {
              todos.add(controller.text);
              controller.text = '';
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
