
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class ChannelDisplayWidget extends StatelessWidget {
  final int channel;


  ChannelDisplayWidget({
    this.channel,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return
      Container(
        height: 50,width: 50,
        decoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0))),

color: Colors.black12,
        child: Text(channel.toString(),  style: TextStyle(color: Colors.lightBlueAccent,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: "Digital"))

      );
  }
}