import 'dart:math';

import 'package:flare_flutter/flare.dart';
import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_dart/math/vec2d.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';

class CyberKnobController extends FlareController {
  ActorNode _control;

  // Storage for our matrix to get global Flutter coordinates into Flare world coordinates.
  Mat2D _globalToFlareWorld = Mat2D();

  // Caret in Flutter global coordinates.
  Vec2D _caretGlobal = Vec2D();

  // Caret in Flare world coordinates.
  Vec2D _caretWorld = Vec2D();

  double _tick = 1.0;
  double _ticker = -0.1;

  FlutterActorArtboard _artboard;
  FlareAnimationLayer _rotationAnimation;
  ActorAnimation _rotation;

  @override
  void initialize(FlutterActorArtboard artboard) {
    _artboard = artboard;
    _rotationAnimation = FlareAnimationLayer()
      ..animation = artboard.getAnimation("Untitled");
    _rotation = artboard.getAnimation("Untitled");

    _rotation.apply(0, artboard, 1);
    // play("Untitled");
  }

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    _rotationAnimation.animation.apply(_tick, artboard, 0.5);
    return true;
  }

  set setTick(double tick) {
    _tick += _ticker;
    if (_tick <= 0 || _tick >= 1) {
      _ticker = -_ticker;
    }
  }

  @override
  void setViewTransform(Mat2D viewTransform) {
    // TODO: implement setViewTransform
  }
}
