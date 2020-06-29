
import 'package:equatable/equatable.dart';
import 'package:flutterband/models/message.dart';

abstract class HomeState extends Equatable {
  final int channel;
  const HomeState([this.channel]);
}

class InitialHomeState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadedState extends HomeState {
  @override
  List<Object> get props => [];
}

class BroadcastingState extends HomeState {
  @override
  List<Object> get props => [];
}

class BroadcastSentState extends HomeState {
  final Message message;
  final int channel;
  @override
  List<Object> get props => [message];
  const BroadcastSentState([this.message,this.channel]);
}

class IncomingMessageState extends HomeState {
  final String message;
  final int channel;
  @override
  List<Object> get props => [message,channel];
  const IncomingMessageState([this.message,this.channel]);
}

class ChannelBrowseState extends HomeState {
  @override
  final int channel;
  const ChannelBrowseState([this.channel]);
  @override
  List<Object> get props => [channel];
}


