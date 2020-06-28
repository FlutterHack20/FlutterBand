import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutterband/widgets/knobs/cyber_knob/cyber_knob_controller.dart';

class CyberKnob extends StatefulWidget {
  CyberKnob({Key key}) : super(key: key);

  @override
  _CyberKnobState createState() => _CyberKnobState();
}

class _CyberKnobState extends State<CyberKnob> {
  double _rotation = 0.0;

  CyberKnobController _cyberKnobController = CyberKnobController();

  void _panHandler(DragUpdateDetails d) {
    double radius = 150;

    /// Pan location on the wheel
    bool onTop = d.localPosition.dy <= radius;
    bool onLeftSide = d.localPosition.dx <= radius;
    bool onRightSide = !onLeftSide;
    bool onBottom = !onTop;

    /// Pan movements
    bool panUp = d.delta.dy <= 0.0;
    bool panLeft = d.delta.dx <= 0.0;
    bool panRight = !panLeft;
    bool panDown = !panUp;

    /// Absoulte change on axis
    double yChange = d.delta.dy.abs();
    double xChange = d.delta.dx.abs();

    /// Directional change on wheel
    double verticalRotation = (onRightSide && panDown) || (onLeftSide && panUp)
        ? yChange
        : yChange * -1;

    double horizontalRotation =
        (onTop && panRight) || (onBottom && panLeft) ? xChange : xChange * -1;

    // Total computed change
    double rotationalChange =
        (verticalRotation + horizontalRotation) * (d.delta.distance * 0.2);

    // need to update the knob animation
    setState(() {
      _rotation = rotationalChange;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onPanUpdate: (details) => _panHandler(details),
          onTap: () {
            _cyberKnobController.setTick = 0.1;
          },
          child: Container(
            height: 200,
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: FlareActor(
              "assets/flares/knob_with_glow.flr",
              callback: (value) {
                print('animation ended $value');
              },
              alignment: Alignment.bottomCenter,
              fit: BoxFit.contain,
              controller: _cyberKnobController,
            ),
          ),
        ),
        Text('Rotation: $_rotation'),
      ],
    );
  }
}
