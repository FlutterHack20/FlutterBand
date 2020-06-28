import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterband/models/message.dart';

class EarwigBloc extends Bloc<EarwigEvent, EarwigState> {
  @override
  EarwigState get initialState => InitialEarwigState();

  @override
  Stream<EarwigState> mapEventToState(
    EarwigEvent event,
  ) async* {
    if (event is StartListeningEvent) {
      yield* _mapListeningEventToState(event, event.channel);
    }
  }

  Stream<EarwigState> _mapListeningEventToState(
      EarwigEvent event, String channel) async* {
    print("***CONNECTING TO DB ON CHANNEL ${channel}***");
    Firestore _firestore = Firestore.instance;
    await for (var snapshot in _firestore.collection(channel).snapshots()) {
      for (var message in snapshot.documentChanges) {
        print(message.document.data);
        Message newMessage = Message.fromEntity(message.document.data);
        yield MessageReceivedEarwigState(newMessage);
      }
    }
    ;
  }
}
