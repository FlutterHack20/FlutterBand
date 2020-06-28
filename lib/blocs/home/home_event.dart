import 'package:equatable/equatable.dart';
import 'package:flutterband/models/message.dart';

abstract class HomeEvent  extends Equatable {
  const HomeEvent();
}
class InitialHomeEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class StartBroadcastEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class VoiceProcessedEvent extends HomeEvent{
  @override
  List<Object> get props => [];
}
class VoiceErrorEvent extends HomeEvent{
  @override
  List<Object> get props => [];
}

class StartIncomingEvent extends HomeEvent {
  final Message message;
  final String languageCode;
  @override
  List<Object> get props => [message,languageCode];
  const StartIncomingEvent([this.message,this.languageCode]);
}