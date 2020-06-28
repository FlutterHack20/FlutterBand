import 'package:flare_flutter/flare.dart';
import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare_controller.dart';

class CyberSwitchController extends FlareController {
  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    return true;
  }

  @override
  void initialize(FlutterActorArtboard artboard) {}

  @override
  void setViewTransform(Mat2D viewTransform) {}
}
