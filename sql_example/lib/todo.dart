class Todo {
  String title;
  String content;
  int active;
  int? id;

  Todo(
      {required this.title,
      required this.content,
      required this.active,
      this.id});

  //sqlite는 true/false를 체크하는 bool타입이 없습니다. 그래서 Integer 정수를
  //이용해서 true 1, false 0으로 처리해주면 됩니다.
  //toMap()는 Map형태로 반환해 줍니다. sqflite패키지는 데이터를 Map형태로 되어 있다.
  //그리서 toMap으로 Nap형태로 바꿔줘야한다.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'active': active,
    };
  }
}
