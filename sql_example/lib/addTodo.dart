import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_example/todo.dart';

class AddTodoApp extends StatefulWidget {
  final Future<Database> db;
  AddTodoApp({Key? key, required this.db}) : super(key: key);

  @override
  State<AddTodoApp> createState() => _AddTodoApp();
}

class _AddTodoApp extends State<AddTodoApp> {
  //컨트롤러
  TextEditingController? titleController;
  TextEditingController? contentController;

  @override
  void initState() {
    super.initState();

    //초기화
    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo 추가'),
      ),
      body: Container(
        child: Center(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: '제목'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: '할일'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Todo todo = Todo(
                    title: titleController!.value.text,
                    content: contentController!.value.text,
                    active: 0);
                Navigator.of(context).pop(todo);
              },
              child: Text('저장하기'),
            )
          ],
        )),
      ),
    );
  }
}
