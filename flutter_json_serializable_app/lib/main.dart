import 'package:flutter/material.dart';
import 'dart:convert';

import 'user.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

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
    String json = '{"name":"홍길동","email":"honggildong@example.com","createdtime":11100722}';
    Map<String, dynamic> userMap = jsonDecode(json);

    var user = User.fromJson(userMap);
    var jsonData = user.toJson();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          'name: ${user.name} \n email: ${user.email} \n created_time: ${user.createdTime} \n toJson: ${jsonData}',textScaleFactor: 2,
        ),
      ),
    );
  }
}

