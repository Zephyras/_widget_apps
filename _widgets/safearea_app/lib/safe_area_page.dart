
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SafeAreaPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: Scaffold(
        body: ListView(
          children: List.generate(
            100,
                (index) => ListTile(title: Text('Item $index'),),),
        ),
      ),
    );
  }

}