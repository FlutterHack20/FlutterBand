import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutterband/widgets/cyber_switch/cyber_switch_controller.dart';

class CyberSwitch extends StatefulWidget {
  CyberSwitch({Key key}) : super(key: key);

  @override
  _CyberSwitchState createState() => _CyberSwitchState();
}

class _CyberSwitchState extends State<CyberSwitch> {
  CyberSwitchController _cyberSwitchController = CyberSwitchController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlareActor(
        "assets/flares/switch.flr",
        controller: _cyberSwitchController,
      ),
    );
  }
}
