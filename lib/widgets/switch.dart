import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterband/blocs/earwig/earwig_bloc.dart';
import 'package:flutterband/blocs/earwig/earwig_event.dart';

class Switcher extends StatefulWidget {
  // Function currentChannel;
  final String channel;
  Switcher(this.channel);

  @override
  _SwitcherState createState() => _SwitcherState(channel);
}

class _SwitcherState extends State<Switcher> {
  final String channel;
  _SwitcherState(this.channel);

  bool switchEnabled = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          switchEnabled = !switchEnabled;
          switchEnabled
              ? BlocProvider.of<EarwigBloc>(context)
                  .add(StartListeningEvent(int.parse(channel)))
              : BlocProvider.of<EarwigBloc>(context).add(StopListeningEvent());
        });
      },
      child: new FlareActor("assets/flares/switch_v03_red.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: switchEnabled ? "enable" : "disable"),
    );
  }
}
