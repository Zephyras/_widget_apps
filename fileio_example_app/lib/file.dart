
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileApp extends StatefulWidget {
  const FileApp({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<FileApp> createState() => _FileApp();
}

class _FileApp extends State<FileApp> {
  int _counter = 0;
  Future<List<String>> readListFile() async{
    List<String> itemList = new List.empty(growable: true);
    var key = 'first';
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? firstCheck = pref.getBool(key);
    var dir = await getApplicationDocumentsDirectory();
    bool fileExist = await File(dir.path + '/fruit.txt').exists();

    if(firstCheck == null || firstCheck == false || fileExist == false){
      pref.setBool(key, true);
      var file = await DefaultAssetBundle.of(context).loadString('assets/repo/fruit.txt');
      File(dir.path + '/fruit.txt').writeAsString(file);

      var array = file.split('\n');
      for(var item in array){

      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readCountFile();
  }
  void _incrementCounter() {
    setState(() {
      _counter++;

    });
    writeCountFile(_counter);
  }

  void writeCountFile(int count) async{
    var dir = await getApplicationDocumentsDirectory();
    File(dir.path + '/count.txt').writeAsString(count.toString());
  }

  void readCountFile() async{
    try{
      var dir = await getApplicationDocumentsDirectory();
      var file = await File(dir.path + '/count.txt').readAsString();
      print(file);
      setState(() {
        _counter = int.parse(file);
      });
    }
    catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Center(
          child: Text('$_counter',
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}