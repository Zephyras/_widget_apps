import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:flutter_json_app/user.dart';

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
    String json = '{"name":"홍길동","email":"honggildong@example.com","created_time":11100722}';
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

//디코딩
class User{
  final String name;
  final String email;
  final int createdTime;

  User(this.name, this.email, this.createdTime);

  //formJson
  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        createdTime = json['created_time'];
  //ToJosn
  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'email' : email,
        'created_time': createdTime,
      };
}