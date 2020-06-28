import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class MessageDisplayWidget extends StatelessWidget {
  final String message;


  MessageDisplayWidget({
    this.message,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Marquee(
      text: message,
      style: TextStyle(color: Colors.greenAccent,fontSize: 50,fontWeight: FontWeight.bold,fontFamily: "Digital"),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      blankSpace: 20.0,
      velocity: 100.0,
      startPadding: 10.0,

    );
  }
}