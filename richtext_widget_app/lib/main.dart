import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('RichText Widget\n')),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start ,
            children: [
              //리치텍스트 여러개의 다른 스타일을 가진 문자를 화면에 그린다.
              //TextSpan을 사용한다 다른텀은 text.rich는 기본적으로 DefaultTextStyle을 기본적으로 적용하지만
              //RichText는 그렇지 않기 때문에 기본스타일을 명시해야한다.
                RichText(
                  text:TextSpan(text: 'RichText Widget\n',
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: 'Bold\n', style: TextStyle(fontWeight: FontWeight.bold
                    )
                    ),
                    TextSpan(
                        text: 'Bold\n', style: TextStyle(fontWeight: FontWeight.normal
                    )
                    ),
                    TextSpan(text: 'Bold\n', style: TextStyle(color: Colors.black, fontSize: 36),)
                  ]),
                ),
              //Text.rich
              Text.rich(
                TextSpan(
                text: 'text.rich widget\n',
                children: [
                  TextSpan(
                    text: 'Text.rich TextSpan'),
                  TextSpan(
                    text:'TextSpan widget',
                    style: TextStyle(color:  Colors.red),
                  ),
              ],
              )),

            ],
          ),
        ),
      ),
    );
  }
}