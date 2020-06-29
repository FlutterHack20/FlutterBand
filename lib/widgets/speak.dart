import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterband/blocs/home/bloc.dart';

class Speak extends StatefulWidget {
  Function currentChannel;
  Speak([this.currentChannel]);

  @override
  _SpeakState createState() => _SpeakState(currentChannel);

}

class _SpeakState extends State<Speak> {
  Function currentChannel;
  _SpeakState([this.currentChannel]);
  bool switchEnabled = true;
  final FlareControls controls = FlareControls();
  void _playSuccessAnimation() {
    // Use the controls to trigger an animation.
    controls.play("enable");
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          switchEnabled = !switchEnabled;
          _playSuccessAnimation();
          BlocProvider.of<HomeBloc>(context).add(StartBroadcastEvent(currentChannel()));
        });
      },
      child: new FlareActor("assets/flares/recordButton.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          controller: controls,
          animation:"enable"),
    );
  }
}
