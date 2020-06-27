import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  StreamSubscription cameraBlocSubscription;


  @override
  Future<void> close() {
    cameraBlocSubscription.cancel();
    return super.close();
  }
  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event,) async* {

  }

}