import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
  //const MyApp({});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Json Sample'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //< 샘플 tojson
    String json = '{"name":"홍길동","email":"honggildong@example.com","created_time":11100722}';
    Map<String, dynamic> userMap = jsonDecode(json);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: [Text(
            'name: ${userMap['name']} \n email: ${userMap['email']} \n created_time: ${userMap['created_time']}',textScaleFactor: 2,
          ),],
        ),
      ),
    );
  }
}
