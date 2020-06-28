import 'package:meta/meta.dart';

@immutable
abstract class EarwigEvent {}

class StartListeningEvent extends EarwigEvent {
  final String channel;
  @override
  List<Object> get props => [channel];
  StartListeningEvent([this.channel]);
}
