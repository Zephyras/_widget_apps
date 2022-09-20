import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:sql_example/todo.dart';

import 'addTodo.dart';
import 'clearList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DatabaseApp(db: database),
        '/add': (context) => AddTodoApp(db: database),
        '/clear': (context) => ClearListApp(db: database)
      },
    );
  }
}

///메인 14줄
///initDatabase()함수는 데이터베이스를 열어서 반환해줍니다.
///이때 데이터베이스는 getDatabasePath()함수가 반환하는 경로에 todo_database.db 라는 파일로
///저장되어 있으며 이파일을 불러와서 반환합니다.
///만약 DB를 확인후 파일에 테이블이 없으면 onCreate를 이용해 새로운 데이터베이스 테이블을 만듭니다.
Future<Database> initDatabase() async {
  return openDatabase(
    p.join(await getDatabasesPath(), 'todo_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "title TEXT, content TEXT, active INTEGER)",
      );
    },
    version: 1,
  );
}

class DatabaseApp extends StatefulWidget {
  final Future<Database> db;

  const DatabaseApp({Key? key, required this.db}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DatabaseApp();
}

class _DatabaseApp extends State<DatabaseApp> {
  Future<List<Todo>>? todoList;

  ///widget.db를 이용해 database객체를 선언하고 insert()함수를 이요해 매개변수
  ///로 전달받은 데이터를 입력합니다.
  ///database.insert(테이블이름, todo클래스 map으로 반환해주고 데이터베이스에 넣어주는함수)
  ///confilictAlgorithm은 데이터 충돌 발생을 대비하기 위한 기능
  ///만약 데이터가 들어 있을경우 replace를 통해 문자열을 교체해준다.
  void _insertTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.insert('todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    //새로운데이터를 넣어는데 목록이 업데이트 갱신해준다.
    setState(() {
      todoList = getTodos();
    });
  }

  void _updateTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.update(
      'todos',
      todo.toMap(),
      where: 'id = ? ',
      whereArgs: [todo.id],
    );
    setState(() {
      todoList = getTodos();
    });
  }

  void _allUpdate() async {
    final Database database = await widget.db;
    await database.rawUpdate('update todos set active = 1 where active = 0');
    setState(() {
      todoList = getTodos();
    });
  }

  void _deleteTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.delete('todos', where: 'id=?', whereArgs: [todo.id]);
    setState(() {
      todoList = getTodos();
    });
  }

  ///widget.db를 가져와서 database를 선언해준다.
  ///그리고 query('todos')를 통해 maps의 목록을 가져옵니다.
  ///maps의 목록을 활용해 List.generate()함수에 아이템을 넣어 만들어줍니다.
  ///acive를 bool타입처럼 1과0으로 만들어줘서 active: 에 넣어줍니다.
  Future<List<Todo>> getTodos() async {
    final Database database = await widget.db;
    //database todos 테이블이름을 넣어 테이블을 가져온다
    final List<Map<String, dynamic>> maps = await database.query('todos');

    return List.generate(maps.length, (index) {
      int active = maps[index]['active'] == 1 ? 1 : 0;
      return Todo(
          title: maps[index]['title'].toString(),
          content: maps[index]['content'].toString(),
          active: active,
          id: maps[index]['id']);
    });
  }

  //초기화
  @override
  void initState() {
    super.initState();

    //저장할때마다 값이 변화므로 initstate에 getTodos를 호출해준다.
    todoList = getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Database Example'), actions: <Widget>[
          ElevatedButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed('/clear');
                setState(() {
                  todoList = getTodos();
                });
              },
              child: Text(
                '완료한 일',
                style: TextStyle(color: Colors.white),
              ))
        ]),
        body: Container(
          child: Center(
            //FutureBuilder 위젯은 서버에서 데이터를 받거나 파일에 데이터를 가져올때 사용합니다.
            //데이터를 가져올때 시간이 걸리므로 sitch문으로 snapshot.connectionState를 이용해
            //현재 상태를 확인합니다. 만약 상태가 done이되면 가져온 데이터를 ListView.builder를 이용해 보여줍니다.
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
                                  Text(
                                      '체크 : ${todo.active == 1 ? 'true' : 'false'}'),
                                  Container(
                                    height: 1,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                            onTap: () async {
                              Todo result = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('${todo.id} : ${todo.title}'),
                                      content: Text('Todo를 체크하시겠습니까?'),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                todo.active == 1
                                                    ? todo.active = 0
                                                    : todo.active = 1;
                                              });
                                              Navigator.of(context).pop(todo);
                                            },
                                            child: Text('예')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(todo);
                                            },
                                            child: Text('아니요')),
                                      ],
                                    );
                                  });
                              _updateTodo(result);
                            },
                            onLongPress: () async {
                              Todo result = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('${todo.id} : ${todo.title}'),
                                      content:
                                          Text('${todo.content}를 삭제하시겠습니까?'),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(todo);
                                            },
                                            child: Text('예')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('아니요')),
                                      ],
                                    );
                                  });
                              _deleteTodo(result);
                            },
                          );
                        },
                        itemCount: (snapshot.data as List<Todo>).length,
                      );
                    } else {
                      return Text('No data');
                    }
                }
                return CircularProgressIndicator();
              },
              future: todoList,
            ),
          ),
        ),
        floatingActionButton: Column(
          children: <Widget>[
            FloatingActionButton(
              onPressed: () async {
                final todo = await Navigator.of(context).pushNamed('/add');
                if (todo != null) {
                  _insertTodo(todo as Todo);
                }
              },
              heroTag: null,
              child: Icon(Icons.add),
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: () async {
                _allUpdate();
              },
              heroTag: null,
              child: Icon(Icons.update),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ));
  }
}
