import 'package:dartatable_widget_app/datatable2.dart';
import 'package:flutter/material.dart';

import 'datatable.dart';

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
      home: Scaffold(
        appBar: AppBar(
          title: Text('DataTable'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            dataTable(),
            dataTable2(),
          ],
        )),
      ),
    );
  }
}
