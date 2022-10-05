import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//그리드 뷰 만들고 히어로위젯으로 전환할때 애니메이션 효과 주기.
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: ((context) => PageRoute())));
          },
          child: Hero(
            tag: "tag",
            child: Image.network(
              'https://cdn.pixabay.com/photo/2022/09/21/05/39/birds-7469509_1280.jpg',
            ),
          )),
    );
  }
}

class PageRoute extends StatelessWidget {
  final List<String> image_list = [
    'https://cdn.pixabay.com/photo/2022/09/21/05/39/birds-7469509_1280.jpg',
    'https://cdn.pixabay.com/photo/2022/09/25/04/15/seagull-7477585_1280.jpg',
  ];
  PageRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Hero(
            tag: "tag",
            child: Image.network(
              image_list[0],
            )));
  }
}
