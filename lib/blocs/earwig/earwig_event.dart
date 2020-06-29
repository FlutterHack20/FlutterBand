import 'package:flutterband/models/message.dart';
import 'package:meta/meta.dart';

@immutable
abstract class EarwigEvent {}

class StartListeningEvent extends EarwigEvent {
  final int channel;
  @override
  List<Object> get props => [channel];
  StartListeningEvent([this.channel]);
}

class StopListeningEvent extends EarwigEvent {
  @override
  List<Object> get props => [];
}

class PushMessageEvent extends EarwigEvent {
  final Message message;
  List<Object> get props => [message];
  PushMessageEvent([this.message]);
}
