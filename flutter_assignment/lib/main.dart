import './textControl.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  var _text = "WINayIScrazy";

  
  void _changeText() {
   setState(() {
      _text="DUSTbinAY";
   });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Assignmet1'),
        ),
        body: TextControl(_text,_changeText),
      ),
    );
  }
}
