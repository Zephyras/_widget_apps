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
        appBar: AppBar(title: Text('TextWidget')),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
            children: [
              Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              textAlign: TextAlign.center,
              textScaleFactor: 2,
              textDirection: TextDirection.ltr,
              locale: Locale("en", ""),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              semanticsLabel: 'Head',
              textWidthBasis: TextWidthBasis.longestLine,
              textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: true, applyHeightToLastDescent: true),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              //TextSpan()
            ],
          ),
        ),
      ),
    );
  }
}
