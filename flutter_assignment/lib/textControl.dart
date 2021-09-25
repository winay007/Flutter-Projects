import 'package:flutter/material.dart';

class TextControl extends StatelessWidget {
  final String text;
  final VoidCallback changeText;
 
  TextControl(this.text,this.changeText);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 34,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        RaisedButton(
          child: Text('Change text'),
          color: Colors.orange,
          textColor: Colors.white,
          onPressed: changeText,
        ),
      ]),
    );
  }
}
