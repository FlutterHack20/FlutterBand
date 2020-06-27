import 'package:equatable/equatable.dart';

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