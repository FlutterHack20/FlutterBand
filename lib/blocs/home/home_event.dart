import 'package:equatable/equatable.dart';
import 'package:flutterband/blocs/home/bloc.dart';

abstract class HomeEvent  extends Equatable {
  const HomeEvent();
}
class InitialHomeEvent extends HomeState {
  @override
  List<Object> get props => [];
}