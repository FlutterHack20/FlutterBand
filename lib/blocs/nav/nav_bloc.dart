import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../blocs/nav/bloc.dart';

class NavBloc extends Bloc<NavEvent, NavState> {



  @override
  NavState get  initialState {

    return InitialNavState();

  }

  @override
  Stream<NavState> mapEventToState(
    NavEvent event,
  ) async* {

    if(event is NavHomeEvent) {
      yield HomeNavState();
    }


  }



}
