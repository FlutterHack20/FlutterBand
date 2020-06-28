
import 'package:equatable/equatable.dart';
import 'package:flutterband/models/message.dart';

abstract class HomeState extends Equatable {
  const HomeState();
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
  @override
  List<Object> get props => [message];
  const BroadcastSentState([this.message]);
}

class IncomingMessageState extends HomeState {
  final String message;
  @override
  List<Object> get props => [message];
  const IncomingMessageState([this.message]);
}

