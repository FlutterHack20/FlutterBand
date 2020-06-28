import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import './cyber_knob_controller.dart';

double _convertRange(oldMin, oldMax, newMin, newMax, oldValue) {
  return (((oldValue - oldMin) * (newMax - newMin)) / (oldMax - oldMin)) +
      newMin;
}

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
  double radius = 100;

  double _movement = 0.0;

  CyberKnobController _cyberKnobController = CyberKnobController();

  void _debugPan(dynamic d) {
    if (d.delta.dx > 0)
      print("Dragging in +X direction");
    else
      print("Dragging in -X direction");

    if (d.delta.dy > 0)
      print("Dragging in +Y direction");
    else
      print("Dragging in -Y direction");
  }

  double _panUpdate(DragUpdateDetails d) {
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
        (verticalRotation + horizontalRotation) * d.delta.distance;

    bool movingClockwise = rotationalChange > 0;
    bool movingCounterClockwise = rotationalChange < 0;

    setState(() {
      _movement = rotationalChange;
      _cyberKnobController.setTick = _movement;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        height: 200,
        width: 200,
        child: GestureDetector(
          onPanDown: (DragDownDetails details) {
            print('We have contact on drag $details');
          },
          onPanStart: (DragStartDetails details) {
            print('Starting drag $details');
          },
          onPanUpdate: (DragUpdateDetails details) {
            _panUpdate(details);
          },
          onPanEnd: (DragEndDetails details) {
            print('Ended drag $details');
            // _cyberKnobController.setTick = _movement * 0.1;
          },
          onTap: () {
            _cyberKnobController.setTick = 0.1;
          },
          child: Transform(
            transform: Matrix4.rotationY(pi),
            alignment: Alignment.center,
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
