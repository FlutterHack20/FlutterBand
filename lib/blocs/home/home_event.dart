import 'package:equatable/equatable.dart';
import 'package:flutterband/models/message.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class InitialHomeEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class StartBroadcastEvent extends HomeEvent {
  final int channel;
  @override
  List<Object> get props => [channel];
  const StartBroadcastEvent([this.channel]);
}

class VoiceProcessedEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class VoiceErrorEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class StartIncomingEvent extends HomeEvent {
  final Message message;
  final String languageCode;
  final int channel;
  @override
  List<Object> get props => [message, languageCode, channel];
  const StartIncomingEvent([this.message, this.languageCode, this.channel]);
}

class ChannelBrowseEvent extends HomeEvent {
  final int channel;
  const ChannelBrowseEvent([this.channel]);
  @override
  List<Object> get props => [channel];
}