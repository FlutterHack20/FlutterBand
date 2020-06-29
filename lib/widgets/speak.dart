import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterband/blocs/earwig/earwig_bloc.dart';
import 'package:flutterband/blocs/earwig/earwig_event.dart';
import 'package:flutterband/blocs/home/bloc.dart';

class Speak extends StatefulWidget {
  @override
  _SpeakState createState() => _SpeakState();
}

class _SpeakState extends State<Speak> {
  bool switchEnabled = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          BlocProvider.of<HomeBloc>(context).add(StartBroadcastEvent());
        });
      },
      child: new FlareActor("assets/flares/recordButton.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: switchEnabled ? "enable" : "disable"),
    );
  }
}
