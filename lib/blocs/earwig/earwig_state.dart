import 'package:equatable/equatable.dart';

abstract class EarwigState extends Equatable {
  const EarwigState();
}

class InitialEarwigState extends EarwigState {
  @override
  List<Object> get props => [];
}

class MessageReceivedEarwigState extends EarwigState {
  final dynamic message;
  @override
  List<Object> get props => [message];
  const MessageReceivedEarwigState([this.message]);
}
