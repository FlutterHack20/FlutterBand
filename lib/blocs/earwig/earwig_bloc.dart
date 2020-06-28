import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EarwigBloc extends Bloc<EarwigEvent, EarwigState> {
  @override
  EarwigState get initialState => InitialEarwigState();

  @override
  Stream<EarwigState> mapEventToState(
    EarwigEvent event,
  ) async* {
    if (event is StartListeningEvent) {
      yield* _mapListeningEventToState(event);
    }
  }

  Stream<EarwigState> _mapListeningEventToState(EarwigEvent event) async* {
    print("***CONNECTING TO DB***");
    Firestore _firestore = Firestore.instance;
    await for (var snapshot in _firestore.collection('message').snapshots()) {
      for (var message in snapshot.documents) {
        print(message.data);
        yield MessageReceivedEarwigState(message.data);
      }
    }
    ;
  }
}
