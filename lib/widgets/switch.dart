import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterband/blocs/earwig/earwig_bloc.dart';
import 'package:flutterband/blocs/earwig/earwig_event.dart';

class Switcher extends StatefulWidget {
  @override
  _SwitcherState createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  bool switchEnabled = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          switchEnabled = !switchEnabled;
          switchEnabled
              ? BlocProvider.of<EarwigBloc>(context).add(StartListeningEvent())
              : BlocProvider.of<EarwigBloc>(context).add(
                  StopListeningEvent()); //TODO: replace with StopListeningEvent
        });
      },
      child: new FlareActor("assets/flares/switch.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: switchEnabled ? "enable" : "disable"),
    );
  }
}
