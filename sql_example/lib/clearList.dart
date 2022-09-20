import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sql_example/todo.dart';

class ClearListApp extends StatefulWidget {
  Future<Database> db;
  ClearListApp({Key? key, required this.db}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ClearListApp();
}

class _ClearListApp extends State<ClearListApp> {
  Future<List<Todo>>? clearList;

  @override
  void initState() {
    super.initState();
    clearList = getClearList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('이미 한일'),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return CircularProgressIndicator();
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.active:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        Todo todo = (snapshot.data as List<Todo>)[index];
                        return ListTile(
                          title: Text(
                            todo.title!,
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Container(
                            child: Column(
                              children: <Widget>[
                                Text(todo.content!),
                                Container(
                                  height: 1,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: (snapshot.data as List<Todo>).length,
                    );
                  }
              }
              return Text('No data');
            },
            future: clearList,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('완료한 일 삭제'),
                  content: Text('완료한 일을 모두 삭제할까요?'),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text('예')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('아니요')),
                  ],
                );
              });
          if (result == true) {
            _removeAllTodos();
          }
        },
        child: Icon(Icons.remove),
      ),
    );
  }

  Future<List<Todo>> getClearList() async {
    final Database database = await widget.db;
    List<Map<String, dynamic>> maps = await database
        .rawQuery('select title, content, id from todos where active=1');

    return List.generate(maps.length, (index) {
      int active = maps[index]['active'] == 1 ? 1 : 0;
      return Todo(
          title: maps[index]['title'].toString(),
          content: maps[index]['content'].toString(),
          active: active,
          id: maps[index]['id']);
    });
  }

  ///_removeAllTodos()함수는 데이터베이스에서 데이터를 삭제합니다.
  ///delete 문을 사용합니다
  ///delete from todos where acive=1 (todos 테이블 안에 active=1인 모든 데이터를 삭제하라)
  void _removeAllTodos() async {
    final Database database = await widget.db;
    database.rawDelete('delete from todos where active=1');
    setState(() {
      clearList = getClearList();
    });
  }
}
