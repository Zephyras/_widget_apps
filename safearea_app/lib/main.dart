import 'package:flutter/material.dart';
import 'safe_area_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: buildPages(),
    bottomNavigationBar: buildBottomBar(),
  );

  Widget buildBottomBar() => BottomNavigationBar(
    backgroundColor: Theme.of(context).primaryColor,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white70,
    currentIndex: index,
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.health_and_safety),
        label: 'Safe Area',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.label),
        label: 'App Bar',
      ),
    ],
    onTap: (index) => setState(() => this.index = index),
  );

  Widget buildPages() {
    switch (index) {
      case 0:
        return SafeAreaPage();
      case 1:
      default:
        return MyHomePage();
    }
  }
}