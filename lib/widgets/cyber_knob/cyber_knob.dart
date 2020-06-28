import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import './cyber_knob_controller.dart';

class CyberKnob extends StatefulWidget {
  // Define the parameters of this widget
  final double value;
  final double min;
  final double max;

  // Two extra parameters to make the widget more easy to customise
  final double size;

  // ValueChanged is a type built into Dart for a function that changes a value
  final ValueChanged<double> onChanged;

  CyberKnob({
    Key key,
    this.value = 0.0,
    this.min = 0.0,
    this.max = 1.0,
    this.size = 200.0,
    this.onChanged,
  }) : super(key: key);

  @override
  _CyberKnobState createState() => _CyberKnobState();
}

class _CyberKnobState extends State<CyberKnob> {
  static const double minAngle = -160;
  static const double maxAngle = 160;
  static const double sweepAngle = maxAngle - minAngle;

  CyberKnobController _cyberKnobController = CyberKnobController();

  void _panHandler(DragUpdateDetails d) {
    // need to update the knob animation
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        height: 200,
        width: 200,
        child: GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            if (details.delta.dx > 0)
              print("Dragging in +X direction");
            else
              print("Dragging in -X direction");

            if (details.delta.dy > 0)
              print("Dragging in +Y direction");
            else
              print("Dragging in -Y direction");

            print(details.delta.distance);
          },
          onTap: () {
            _cyberKnobController.setTick = 0.1;
          },
          child: Transform.rotate(
            angle: 180,
            child: FlareActor(
              "assets/flares/knob.flr",
              callback: (value) {
                print('animation ended $value');
              },
              alignment: Alignment.bottomCenter,
              fit: BoxFit.contain,
              controller: _cyberKnobController,
            ),
          ),
        ),
      ),
    );
  }
}
