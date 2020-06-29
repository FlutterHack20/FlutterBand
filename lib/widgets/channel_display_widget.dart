import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterband/blocs/home/bloc.dart';

class ChannelDisplayWidget extends StatelessWidget {



  int currentChannel=1;

  ChannelDisplayWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Expanded(
          child: Container(
              alignment: Alignment.center,
              child: Text(
                  currentChannel.toString(),
                  style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 200,
                      // fontWeight: FontWeight.bold,
                      fontFamily: "Digital"))));
    });

  }
}
